### Vuex

1. 实现 Vuex 原理是什么?

   > 将数据抽离到全局，以一个单例存放，同时利用 Vue 的响应式机制来进行搞笑的状态管理和更新(new 一个 Vue 对象来实现响应式化)。这也是 Vuex 只能与 Vue 搭配使用。

2. Vuex 怎么把 store 注入到每个**Vue 实例**中去的呢？
   > 使用 Vuex 的时候，需要使用 Vue.use(Vuex),这里 Vue.use 方法内部是调用了 install 方法

```javascript

Vue.use(Vuex);

// 将store放入Vue创建时的option中
new Vue({
  el: '#app',
  store
})

// 暴露给外部的插件install方法，供Vue.use调用安装插件
install (_Vue) {
  if (Vue) {
    // 避免重复安装(Vue.use 内部也会检测一次是否重复安装统一插件)
    if (process.env.NODE_ENV !== 'production') {
      console.log('[vuex] already installed. Vue.use(Vuex) should be called only once.')
    }
    return
  }
  // 保存Vue，同时用于检测是否重复安装
  Vue = _Vue
  // 将vuexInit混淆进Vue的beforeCreate
  applyMixin(Vue)
}

这段install代码做了两件事情，一件是防止Vuex被重复安装，另一件是执行applyMixin，目的是执行vuexInit方法初始化Vuex。

// Vuex的init钩子，会存入每一个Vue实例等钩子列表
function vuexInit () {
  const options = this.$options
  if (options.store) {
    // 存在store其实代表就是Root节点，直接执行store(function时)或者使用store(非function)
    this.$store = typeof options.store === 'function' ? options.store() : options.store
  } else if (options.parent && options.parent.$store) {
    // 子组件直接从父组件中获取$store，这样保证所有组件都用了全局的同一份store
    this.$store = options.parent.$store
  }
}

vuexInit会尝试从options中获取store，如果当前组件是根组件(Root节点)，则options中会存在store，直接获取赋值给$store即可。如果当前组件非根组件，则通过options中的parent获取父组件的
$store引用，这样所有的组件都获取到同一份内存地址的Store实例，于是我们可以在每一个组件中通过this.$store愉快的访问全局的Store实例了。
```

3. commit 怎么实现的?

```javascript
// 调用mutation的commit方法
commit (_type, _payload, _options) {
  // 校验参数
  const { type, payload, options } = unifyObjectStyle(_type, _payload, _options);
  const mutation = { type, payload };
  // 取出type对应的mutation的方法
  const entry = this._mutation[type]
  if (!entry) {
    if (process.env.NODE_ENV !== 'production') {
      console.error(`[vuex] unknown mutation type: ${type}`)
    }
    return
  }

  // 执行mutation中的所有方法
  this._withCommit(() => {
    entry.forEach(function commitIterator (handler) {
      handler(payload);
    })
  })

  // 通知所有订阅者
  this._subscribers.forEach(sub => sub(mutation, this.state))
}

```

commit 方法会根据 type 找到并调用\_mutations 中的所有 type 对应的 mutation 方法，commit 方法会触发所有 module 中的 mutation 方法，再执行完所有的 mutation 之后会执行\_subscribers 中的所有订阅者。

4. dispatch 怎么实现的？

```javascript
// 调用action的dispatch方法
dispatch (_type, _payload) {
  const { type, payload } = unifyObjectStyle(_type, _payload);

  // actions中取出type对应的action
  const entry = this._actions[type]
  if (!entry) {
    if (process.env.NODE_ENV !== 'production') {
      console.error(`[vuex] unknown action type: ${type}`)
    }
    return
  }

  // 是数组则包装Promise形成一个新的Promise，只有一个则直接返回第0个
  // 这里entry是一个Promise对象
  return entry.length > 1 ? Promise.all(entry.map(handler => handler(payload))) : entry[0](payload);
}


/* 遍历注册action */
function registerAction (store, type, handler, local) {
  /* 取出type对应的action */
  const entry = store._actions[type] || (store._actions[type] = [])
  entry.push(function wrappedActionHandler (payload, cb) {
    let res = handler.call(store, {
      dispatch: local.dispatch,
      commit: local.commit,
      getters: local.getters,
      state: local.state,
      rootGetters: store.getters,
      rootState: store.state
    }, payload, cb)
    /* 判断是否是Promise */
    if (!isPromise(res)) {
      /* 不是Promise对象的时候转化称Promise对象 */
      res = Promise.resolve(res)
    }
    if (store._devtoolHook) {
      /* 存在devtool插件的时候触发vuex的error给devtool */
      return res.catch(err => {
        store._devtoolHook.emit('vuex:error', err)
        throw err
      })
    } else {
      return res
    }
  })
}


```

因为 registerAction 的时候将 push 进\_actions 的 action 进行了一层封装（wrappedActionHandler），所以我们在进行 dispatch 的第一个参数中获取 state、commit 等方法。之后，执行结果 res 会被进行判断是否是 Promise，不是则会进行一层封装，将其转化成 Promise 对象。dispatch 时则从\_actions 中取出，只有一个的时候直接返回，否则用 Promise.all 处理再返回。

5. 如何实现 Vuex 响应式的？

```javascript
// 通过vm重设store，新建Vue对象使用Vue内部的响应式实现注册state以及computed
function resetStoreVM(store, state, hot) {
  // 存放之前的vm对象
  const oldVm = store._vm;
  store.getters = {};
  const wrappedGetters = store._wrappedGetters;
  const computed = {};

  // 通过Object.defineProperty为每一个getter方法设置get方法，比如获取this.$store.getters.test的时候获取
  // 的是store._vm.test，也就是Vue对象的computed属性
  forEachValue(wrappedGetters, (fn, key) => {
    computed[key] = () => fn(store);
    Object.defineProperty(store.getters, key, {
      get: () => store._vm[key],
      enumerable: true,
    });
  });
  // 这里new了一个Vue对象，运用Vue内部的响应式实现注册state以及computed
  store._vm = new Vue({
    data: {
      $$state: state,
    },
    computed,
  });
}
```

reseteStoreVM 首先会遍历 wrappedGetters，使用 Object.defineProperty 方法为每一个 getter 绑定 get 方法，这样我们就可以在组件里访问 this.$store.getters.test 就等同于访问 store.\_vm.test,之后 Vuex 采用了 new 一个 Vue 对象来实现数据的响应式化，运用 Vue 内部提供的数据双向绑定功能来实现 store 的数据与视图的同步更新。

```javascript
store._vm = new Vue({
  data: {
    $$state: state,
  },
  computed,
});
```

这时候我们访问 store.\_vm.test 也就访问了 Vue 实例中的属性，
这两步执行完之后，我们就可以通过 this.$store.getters.test 属性了。
