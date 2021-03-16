### instanceof
定义：`instanceof` **运算符**用于检测构造函数的 **prototype** 属性是否出现在某个实例对象的原型链上。

这个运算符平常也会用到，但都没有研究其内部是怎么实现的，心里总觉得堵塞😄，所以今天来实现一个`instanceof`。
<!-- 
我们从定义上面可以知道两点，
1. 检测构造函数的**prototype**
2. 它是不是在实例对象的原型链上 -->

先来看看正房`instanceof`例子：

```javascript

// 定义构造函数
function C(){}
function D(){}

var o = new C();

o instanceof C; // true，因为 Object.getPrototypeOf(o)(或者o.__proto__) === C.prototype

o instanceof D; // false，因为 D.prototype 不在 o 的原型链上

o instanceof Object; // true，因为 Object.prototype.isPrototypeOf(o) 返回 true
C.prototype instanceof Object // true，同上

C.prototype = {};
var o2 = new C();

o2 instanceof C; // true

o instanceof C; // false，C.prototype 指向了一个空对象,这个空对象不在 o 的原型链上.

D.prototype = new C(); // 继承
var o3 = new D();
o3 instanceof D; // true
o3 instanceof C; // true 因为 C.prototype 现在在 o3 的原型链上

上面这些例子都是在MDN上copy的😄

```
老爷想娶个偏房(自定义`instanceof`)，以备不时之需😄

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


// 定义构造函数
function C(){}
function D(){}

var o = new C();

_instanceof (o, C); // true，因为 Object.getPrototypeOf(o)(或者o.__proto__) === C.prototype

_instanceof (o, D); // false，因为 D.prototype 不在 o 的原型链上

_instanceof (o, Object); // true，因为 Object.prototype.isPrototypeOf(o) 返回 true
_instanceof (C.prototype, Object); // true，同上

C.prototype = {};
var o2 = new C();

_instanceof (o2, C); // true

_instanceof (o, C); // false，C.prototype 指向了一个空对象,这个空对象不在 o 的原型链上.

D.prototype = new C(); // 继承
var o3 = new D();
_instanceof (o3, D); // true
_instanceof (o3, C); // true 因为 C.prototype 现在在 o3 的原型链上

```

