#Object.freeze
`Object.freeze()` 方法可以冻结一个对象，冻结指的是不能向这个对象添加新的属性，不能修改其已有属性的值，不能删除已有属性，以及不能修改该对象已有属性的可枚举性、可配置性、可写性。也就是说，这个对象永远是不可变的。该方法返回被冻结的对象。

#语法
`Object.freeze(obj)` obj: 要被冻结的对象，返回值：被冻结的对象

Examples

#冻结对象

```javascript

var obj = {
  prop: function() {},
  foo: 'bar'
};

// 新的属性会被添加, 已存在的属性可能
// 会被修改或移除
obj.foo = 'baz';
obj.lumpy = 'woof';
delete obj.prop;

// 作为参数传递的对象与返回的对象都被冻结
// 所以不必保存返回的对象（因为两个对象全等）
var o = Object.freeze(obj);

o === obj; // true
Object.isFrozen(obj); // === true

// 现在任何改变都会失效
obj.foo = 'quux'; // 静默地不做任何事
// 静默地不添加此属性
obj.quaxxor = 'the friendly duck';

// 在严格模式，如此行为将抛出 TypeErrors
function fail(){
  'use strict';
  obj.foo = 'sparky'; // throws a TypeError
  delete obj.quaxxor; // throws a TypeError
  obj.sparky = 'arf'; // throws a TypeError
}

fail();

// 试图通过 Object.defineProperty 更改属性
// 下面两个语句都会抛出 TypeError.
Object.defineProperty(obj, 'ohai', { value: 17 });
Object.defineProperty(obj, 'foo', { value: 'eit' });

// 也不可能设置属性
// 下面两个语句都会抛出 TypeError.
Object.setPrototypeOf(obj, { x: 20 })
obj.__proto__ = { x: 20 }

```

#冻结数组
```javascript

let a = [0];
Object.freeze(a); // The array cannot be modified now.

a[0]=1; // fails silently
a.push(2); // fails silently

// In strict mode such attempts will throw TypeErrors
function fail() {
  "use strict"
  a[0] = 1;
  a.push(2);
}

fail();

```

被冻结的对象是不可变的。但也不总是这样。下例展示了一个不是常量的冻结对象（浅冻结）。

```javascript

obj1 = {
  internal: {}
};

Object.freeze(obj1);
obj1.internal.a = 'aValue';

obj1.internal.a // 'aValue'

```

要使对象不可变，需要递归冻结每个类型为对象的属性（深冻结）。当你知道对象在引用图中不包含任何 环 (循环引用)时，将根据你的设计逐个使用该模式，否则将触发无限循环。对 deepFreeze()  的增强将是具有接收路径（例如Array）参数的内部函数，以便当对象进入不变时，可以递归地调用 deepFreeze() 。你仍然有冻结不应冻结的对象的风险，例如[window]。

```javascript

// 深冻结函数.
function deepFreeze(obj) {

  // 取回定义在obj上的属性名
  var propNames = Object.getOwnPropertyNames(obj); // Object.keys(obj)

  // 在冻结自身之前冻结属性
  propNames.forEach(function(name) {
    var prop = obj[name];

    // 如果prop是个对象，冻结它
    if (typeof prop == 'object' && prop !== null) {
      deepFreeze(prop);
    }
  });

  // 冻结自身(no-op if already frozen)
  return Object.freeze(obj);
}

var obj = {
  internal: {}
};

deepFreeze(obj);
obj.internal.a = 1;
console.log(obj.internal.a); // undefined

```