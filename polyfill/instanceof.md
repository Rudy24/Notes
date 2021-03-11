### instanceof
`instanceof`可以正确的判断对象的类型, 因为内部机制是通过判断对象的**原型链**中是不是可以找到类型的`prototype`

```javascript

// polyfill
function _instanceof (left, right) {
  // 基本类型，null 都直接判定失败
  if (typeof left !== 'object' || left === null) return false
  // 获得类型的原型
  let prototype = right.prototype
  left = left.__proto__
  // 判断对象的类型是否等于类型的原型
  while (true) {
    if (left === null) return false
    if (prototype === left) return true
    left = left.__proto__
  }
}

// 对象
const o = {};
o instanceof Object // true
_instanceof(o, Object); // true


// 函数
function D () {}
const d = new D()
_instanceof(d, D); // true

// 基本类型
const str = ''
_instanceof(str, String); //false

// null
const n = null
_instanceof(n, Object); //false

```

