### Vuex

1. 实现Vuex原理是什么?
> 将数据抽离到全局，以一个单例存放，同时利用Vue的响应式机制来进行搞笑的状态管理和更新(new 一个Vue对象来实现响应式化)。这也是Vuex只能与Vue搭配使用。

2. Vuex怎么把store注入到每个**Vue实例**中去的呢？
> 使用Vuex的时候，需要使用Vue.use(Vuex),这里Vue.use方法内部是调用了install 方法
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
4. dispatch 怎么实现的？
5. 如何实现Vuex响应式的？