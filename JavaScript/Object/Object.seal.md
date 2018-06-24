#Object.seal
`Object.seal()`方法封闭一个对象，阻止添加新属性并将所有现有属性标记为不可配置。当前属性的值只要可写就可以改变。

#语法 
`Object.seal(obj)` 参数：obj 将要被密封的对象，返回值：被密封的对象

#描述

通常，一个对象是可扩展的（可以添加新的属性）。密封一个对象会让这个对象变的不能添加新属性，且所有已有属性会变的不可配置。属性不可配置的效果就是属性变的不可删除，以及一个数据属性不能被重新定义成为访问器属性，或者反之。但属性的值仍然可以修改。尝试删除一个密封对象的属性或者将某个密封对象的属性从数据属性转换成访问器属性，结果会静默失败或抛出TypeError（在严格模式 中最常见的，但不唯一）。

不会影响从原型链上继承的属性。但 __proto__ (  ) 属性的值也会不能修改。

#Examples

```javascript

var obj = {
  prop: function () {},
  foo: 'bar'
};

obj.foo = 'baz';
obj.lumpy = 'woof';
delete obj.prop; // true

console.log(obj);
// {
//   foo: 'baz',
//   lumpy: 'woof'
// }

var o = Object.seal(obj);

o === obj;  // true
Object.isSealed(obj); // true

obj.foo = 'quux'; // quux;

Object.defineProperty(obj, 'foo', {
  get: function () {return 'g';}
}); // throws a TypeError

obj.quaxxor = 'the duck';

console.log(obj);

// {
//   foo: 'baz',
//   lumpy: 'woof'
// }

delete obj.foo; // false

function fail() {
  'use strict'
  delete obj.foo // throws a TypeError
  obj.sparky = 'arf'; // throws a TypeError
}

fail();

Object.defineProperty(obj, 'ohai', {
  value: 17
}); // throws a TypeError

Object.defineProperty(obj, 'foo', {
  value: 'eit'
})

console.log(obj);

// {
//   foo: 'baz',
//   lumpy: 'woof'
// }

```