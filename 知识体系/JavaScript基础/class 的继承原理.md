### class 的继承原理

es6 引入的 class 类实质上是 JavaScript 基于原型继承的语法糖。

```javascript
function Animal(name) {
  this.name = name;
}

Animal.prototype.sayHi = () => {
  return `Hello ${this.name}`;
};

// 等同于

class Animal {
  constructor(name) {
    this.name = name;
  }

  sayHi() {
    return `Hello ${this.name}`;
  }
}
```

让我们来看看通过`babel`转换的`Animal`类。

```javascript
"use strict";

// 
/**
 * 判断left 是否是 right 的实例, 底层利用 instanceof，
 */
function _instanceof(left, right) {
  if (
    right != null &&
    typeof Symbol !== "undefined" &&
    right[Symbol.hasInstance]
  ) {
    return !!right[Symbol.hasInstance](left);
  } else {
    return left instanceof right;
  }
}

function _classCallCheck(instance, Constructor) {
  if (!_instanceof(instance, Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

/**
 * 利用Object.defineProperty添加对象属性
*/
function _defineProperties(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

/**
 * 给构造函数or构造函数原型添加属性or方法
*/
function _createClass(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties(Constructor, staticProps);
  return Constructor;
}

var Animal =
  /*#__PURE__*/
  (function() {
    // 构造函数
    function Animal(name) {
      _classCallCheck(this, Animal);

      this.name = name;
    }

    _createClass(Animal, [
      {
        key: "sayHi",
        value: function sayHi() {
          return "Hello ".concat(this.name);
        }
      }
    ]);

    return Animal;
  })();
```
从以上转义后的代码来看，底层还是采用了原型的继承方式。