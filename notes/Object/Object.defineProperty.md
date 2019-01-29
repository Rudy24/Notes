`Object.defineProperty()`方法会直接在一个对象上定义一个新属性，或者修改一个对象现有属性，并返回这个对象。
在js中我们可以通过下面几种方法定义属性

```javascript

var obj = {};

// 1
obj.name = 'name';

// 2
obj.name2 = 'name2';

// 3
Object.defineProperty(obj, 'name3', {
  value: 'name3'
});

```

语法
`Object.defineProperty(obj=, prop, descriptor)`

参数
`obj`必须，要在其上定义属性的对象
`prop`要定义或修改的属性名称
`descriptor`将被定义或修改的属性描述符

返回值
给传递给函数的对象

我们来关注下这个描述符
属性描述符
对象里面目前存在的属性描述符有两种主要形式，数据描述符和存取描述符。
数据描述符是一个具有值的属性，该值可能是可写的，也可能不是可写的。
存取描述符是由getter-setter函数对描述的属性。

数据描述符和存取描述符都具有以下可选键值：
`configurable`
当且仅当该属性的configurable 为 true时，该属性描述符才能够被改变，同时该属性也能从对应的对象上被删除，默认为false。

`enumerable`当且仅当该属性的enumerable为true时，该属性才能够出现在对象的枚举属性中。默认为false。

数据描述符同时具有以下可选键值：

`value`
该属性对应的值，可以是任何有效的JavaScript值(数值，对象，函数等)。默认为 `undefined`。

`writable`
当且仅当该属性的writable为true时，value才能被赋值运算符改变，默认为false。

存取描述符同时具有以下可选键值：
`get`
一个给属性提供getter的方法，如果没有getter则为`undefined`。该方法返回值被用作属性值。默认为`undefined`

`set`
一个给属性提供 setter 的方法，如果没有 setter 则为 `undefined`。该方法将接受唯一参数，并将该参数的新值分配给该属性。默认为 `undefined`。

````javascript

<!-- 使用__proto__ -->
var obj = {};
var descriptor = Object.create(null); // 没有继承任何属性
// 默认没有enumerable，没有 configurable，没有 writable
descriptor.value = 'static';
Object.defineProperty(obj, 'key', descriptor);

// 显示
Object.defineProperty(obj, 'key', {
  enumerable: false,
  configurable: false,
  writable: false,
  value: 'static'
});

// 循环使用同一对象
function withValue(value) {
  var d = withValue.d || (
    withValue.d = {
      enumerable: false,
      configurable: false,
      writable: false,
      value: null
    }
  );
  d.value = value;
  return d;
}

Object.defineProperty(obj, 'key', withValue('static'));

```

如果对象中不存在指定的属性，`Object.defineProperty()`就创建这个属性。

var o = {}; // 创建一个新对象

// 在对象中添加一个属性与数据描述符的实例
Object.defineProperty(o, 'a', {
  value: 'rudy',
  writable: true,
  enumerable: true,
  configurable: true
});


// 在对象中添加一个属性与存取描述符的实例
var bValue;
Object.defineProperty(o, 'b', {
  get: function () {
    return bValue;
  },
  set: function (newValue) {
    bValue = newValue;
  },
  enumerable: true,
  configurable: true
});

o.b = 38;

`Writable`属性
当writable属性设置为`false`时，该属性被称为不可写。它不能被重新分配
var o = {};

Object.defineProperty(o, 'a', {
  value: 35,
  writable: false
});

// 修改o.a的值
o.a = 24;
console.log(o.a); // 35

`Enumerable`特性
`Enumerable`定义了对象的属性是否可以在`for...in`循环和`Object.keys()`中被枚举。

var o = {};

Object.defineProperty(o, 'a', {value: 1, enumerable: true});
Object.defineProperty(o, 'b', {value: 2, enumberable: false});
Object.defineProperty(o, 'c', {value: 3}); // enumberable默认为false
o.d = 4 // 直接赋值方式创建对象的属性，enumberable为true

for (let key in o) {
  console.log(key);
}
// a,d

Object.keys(o); // ['a', 'd']

o.propertyIsEnumerable('a'); // true
o.propertyIsEnumerable('b'); // false
o.propertyIsEnumerable('c'); // false

`Configurable`特性
`configurable`特性表示对象的属性是否可以被删除，以及除`writable`特性外的其他特性是否可以被修改。
var o = {};
Object.defineProperty(o, 'a', {get: function () {return 1;}, configurable: false});

// throws a TypeError
Object.defineProperty(o, "a", {configurable : true}); 
// throws a TypeError
Object.defineProperty(o, "a", {enumerable : true}); 
// throws a TypeError (set was undefined previously) 
Object.defineProperty(o, "a", {set : function(){}}); 
// throws a TypeError (even though the new get does exactly the same thing) 
Object.defineProperty(o, "a", {get : function(){return 1;}});
// throws a TypeError
Object.defineProperty(o, "a", {value : 12});

console.log(o.a); // logs 1
delete o.a; // Nothing happens
console.log(o.a); // logs 1



function Archiver () {
  var temperature = null;
  var archive = [];

  Object.defineProperty(this, 'temperature', {
    get: function () {
      console.log('get!');
      return temperature;
    },
    set: function (value) {
      temperature = value;
      archive.push({val: temperature})
    }
  });

  this.getArchive = function () { return archive;}
}

// ES5有三个操作会忽略enumerable为false的属性。

// for...in循环：只遍历对象自身的和继承的可枚举的属性
// Object.keys()：返回对象自身的所有可枚举的属性的键名
// JSON.stringify()：只串行化对象自身的可枚举的属性

1. 基于数据劫持实现的双向绑定的特点
// 1.1 什么是数据劫持
数据劫持--在属性值发生变化时，我们可以获取到变化，从而进行下一步操作

// 
const data = {
  name: '',
};

function say(name) {
  if (name === 'rudy') {
    console.log('rudy');
  } else if (name === 'kobe') {
    console.log('kobe');
  } else {
    console.log('hello world');
  }
}

// 遍历对象,对其属性值进行劫持
Object.keys(data).forEach(function(key) {
  Object.defineProperty(data, key, {
    enumerable: true,
    configurable: true,
    get: function() {
      console.log('get');
    },
    set: function(newVal) {
      // 当属性值发生变化时我们可以进行额外操作
      console.log(`大家好,我系${newVal}`);
      say(newVal);
    },
  });
});

data.name;
// get

data.name = 'rudy';
// 大家好,我系rudy
// rudy
