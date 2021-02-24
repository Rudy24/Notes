
function defineReactive (obj, key, val) {
  Object.defineProperty(obj, key, {
    enumerable: true, // 属性可枚举
    configurable: true, // 属性可修改或者被删除
    get: function () {
      console.log('val', val)
      return val
    },
    set: function (newVal) {
      if (newVal === val) return
      val = newVal
      cb(newVal)
    }
  })
}

function cb (val) {
  console.log("视图更新啦～", val);
}

function observer (value) {
  if (!value || (typeof value !== 'object')) return

  Object.keys(value).forEach(key => {
    defineReactive(value, key, value[key])
  })
}

class Vue {
  constructor (options) {
    this._data = options.data
    observer(this._data)
  }
}

let o = new Vue({
  data: {
    test: 'this is rudy'
  }
})

o._data.test = 'hello world'
console.log(JSON.stringify(o._data))

class Dep {
  constructor () {
    this.subs = []
  }
}