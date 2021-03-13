class Dep {
  constructor() {
    this.subs = [];
  }

  addSub(sub) {
    this.subs.push(sub);
  }

  notify() {
    this.subs.forEach((sub) => {
      sub.update();
    });
  }
}

class Watcher {
  constructor() {
    Dep.target = this;
  }

  update() {
    console.log("试图更新啦~~~");
  }
}

Dep.target = null;

function defineReactive(obj, key, val) {
  /* 一个Dep类对象 */
  const dep = new Dep();

  Object.defineProperty(obj, key, {
    enumerable: true,
    configurable: true,
    get: function reactiveGetter() {
      /* 将Dep.target（即当前的Watcher对象存入dep的subs中） */
      dep.addSub(Dep.target);
      return val;
    },
    set: function reactiveSetter(newVal) {
      if (newVal === val) return;
      val = newVal
      /* 在set的时候触发dep的notify来通知所有的Watcher对象更新视图 */
      dep.notify();
    },
  });
}

function observer(value) {
  if (!value || (typeof value !== 'object')) return

  Object.keys(value).forEach(key => {
    defineReactive(value, key, value[key])
  })
}

class Vue {
  constructor(options) {
    this._data = options.data;
    observer(this._data);
    /* 新建一个Watcher观察者对象，这时候Dep.target会指向这个Watcher对象 */
    new Watcher();
    /* 在这里模拟render的过程，为了触发test属性的get函数 */
    // console.log("render~", this._data.test);
  }
}

let o = new Vue({
  data: {
    test: '111'
  }
})

o._data.test = 'hello world'
console.log(o._data.test)

function deepCopy(source, hash = new WeakMap()) {
  // 如果不是对象，直接返回
  if (!(typeof source === 'object' && source !== null)) return source
  // 如果hash中存在source，直接返回source资源
  if (hash.has(source)) return hash.get(source)
  // 确定是对象or数组
  let target = Array.isArray(source) ? [] : {}
  // 设置缓存
  hash.set(source, target)

  for (let k in source) {
    // 只拷贝自有属性
    if (source.hasOwnProperty(k)) {
      target[k] = typeof source[k] === 'object' && source[k] !== null ? deepCopy(source[k], hash) : source[k]
    }
  }

  return target
}