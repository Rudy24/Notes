1. 概念 <br/>
Proxy 可以理解成，在目标对象之前架设一层拦截，外界对该对象的访问，都必须先通过这层拦截，因此提供了一种机制，可以对外界的访问进行过滤和改写。

```javascript

const obj = new Proxy({}, {
  get: function (target, key, receiver) {
    console.log(`getting ${key}!`);
    return Reflect.get(target, key, receiver);
  },
  set: function (target, key, value, receiver) {
    console.log(`setting ${key}!`);
    return Reflect.set(target, key, value, receiver);
  }
});

```
上面代码对一个空对象架设了一层拦截，重定义了属性的读取(get) 和设置(set)行为。
```javascript

obj.count = 1;
// setting count!
++obj.count;
// getting count!
// setting count!
// 2

```

上面代码说明，Proxy 实际上重载了点运算符，即用自己的定义覆盖了语言的原始定义

#语法
```javascript
var proxy = new Proxy(target, handler);
```
`handler`: 一个对象，用来定制拦截行为
`target`: 表示所要拦截的目标对象

```javascript

var proxy = new Proxy({}, {
  get: function (target, property) {
    return 35;
  }
});

proxy.time //35;
proxy.name // 35;
proxy.title // 35;

```
注意，要使得Proxy起作用，必须针对Proxy实例进行操作，而不是针对目标对象进行操作。

```javascript

var target = {};
var handler = {};
var proxy = new Proxy(target, handler);

proxy.a = 'b';
target.a // b

```
上面代码中，`handler`是一个空对象，没有任何的拦截效果，访问`proxy`就等于访问`target`。

同一个拦截器函数，可以设置拦截多个操作。

```javascript
var handler = {
  get: function(target, name) {
    if (name === 'prototype') {
      return Object.prototype;
    }
    return 'Hello, ' + name;
  },

  apply: function(target, thisBinding, args) {
    return args[0];
  },

  construct: function(target, args) {
    return {value: args[1]};
  }
};

var fproxy = new Proxy(function(x, y) {
  return x + y;
}, handler);

fproxy(1, 2) // 1
new fproxy(1, 2) // {value: 2}
fproxy.prototype === Object.prototype // true
fproxy.foo === "Hello, foo" // true

```
下面是 Proxy 支持的拦截操作一览，一共 13 种。


1. get(target, propKey, receiver)：拦截对象属性的读取，比如proxy.foo和proxy['foo']。
2. set(target, propKey, value, receiver)：拦截对象属性的设置，比如proxy.foo = v或proxy['foo'] = v，返回一个布尔值。
3. has(target, propKey)：拦截propKey in proxy的操作，返回一个布尔值。
4. deleteProperty(target, propKey)：拦截delete proxy[propKey]的操作，返回一个布尔值。
5. ownKeys(target)：拦截Object.getOwnPropertyNames(proxy)、Object.getOwnPropertySymbols(proxy)、Object.keys(proxy)、for...in循环，返回一个数组。该方法返回目标对象所有自身的属性的属性名，而Object.keys()的返回结果仅包括目标对象自身的可遍历属性。
6. getOwnPropertyDescriptor(target, propKey)：拦截Object.getOwnPropertyDescriptor(proxy, propKey)，返回属性的描述对象。
7. defineProperty(target, propKey, propDesc)：拦截Object.defineProperty(proxy, propKey, propDesc）、Object.defineProperties(proxy, propDescs)，返回一个布尔值。
8. preventExtensions(target)：拦截Object.preventExtensions(proxy)，返回一个布尔值。
9. getPrototypeOf(target)：拦截Object.getPrototypeOf(proxy)，返回一个对象。
10. isExtensible(target)：拦截Object.isExtensible(proxy)，返回一个布尔值。
11. setPrototypeOf(target, proto)：拦截Object.setPrototypeOf(proxy, proto)，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
12. apply(target, object, args)：拦截 Proxy 实例作为函数调用的操作，比如proxy(...args)、proxy.call(object, ...args)、proxy.apply(...)。
13. construct(target, args)：拦截 Proxy 实例作为构造函数调用的操作，比如new proxy(...args)。


2. Proxy 实例的方法 <br/>

####get()
`get`方法用于拦截某个属性的读取操作，可以接受三个参数，依次为目标对象、属性名和proxy实例本身，其中最后一个参数可选。

```javascript

var person = {
  name: 'rudy'
};

var proxy = new Proxy(person, {
  get: function(target, property) {
    if (property in target) {
      return target[property];
    }
    throw new ReferenceError("Property \"" + property + "\" does not exist.");
  }
});

proxy.name // rudy
proxy.age // 报错

```

上面代码表示，如果访问目标对象不存在的属性，会抛出一个错误。如果没有这个拦截函数，访问不存在的属性，只会返回undefined。

`get`方法可以继承
```javascript

let proto = new Proxy({}, {
  get(target, propertyKey, receiver) {
    console.log('GET ' + propertyKey);
    return target[propertyKey];
  }
});

let obj = Object.create(proto);
obj.foo; /// 'GET foo'

```
#set()

`set`方法用来拦截某个属性的赋值操作，可以接受四个参数，依次为目标对象、属性名、属性值和 Proxy 实例本身，其中最后一个参数可选。

假定`Person`对象有一个`age`属性，该属性应该是一个不大于 200 的整数，那么可以使用`Proxy`保证`age`的属性值符合要求。

```javascript

let validator = {
  set: function (obj, prop, value) {
    if (prop === 'age') {
      if (!Number.isInteger(value)) {
        throw new TypeError('The age is not an integer');
      }
      if (value > 200) {
        throw new RangeError('The age seems invalid');
      }
    }
    // 对于满足条件的 age 属性及其他属性，直接保存
    obj[prop] = value;
  }
};

let perons = new Proxy({}, validator);
person.age = 100;
person.age // 100;
person.age = 'young'; // 报错
person.age = 300; // 报错

```
上面代码中，由于设置了存储函数`set`，任何不符合要求的`age`属性赋值，都会抛出一个错误

```javascript

const handler = {
  get (target, key) {
    invariant(key, 'get');
    return target[key];
  },
  set (target, key, value) {
    invariant(key, 'set');
    target[key] = value;
    return true;
  }
};

function invariant (key, action) {
  if (key[0] === '_') {
    throw new Error(`Invalid attempt to ${action} private "${key}" property`);
  }
}

const target = {};
const proxy = new Proxy(target, handler);
proxy._prop
// Error: Invalid attempt to get private "_prop" property
proxy._prop = 'c'
// Error: Invalid attempt to set private "_prop" property

```
上面代码中，只要读写的属性名的第一个字符是下划线，一律抛错，从而达到禁止读写内部属性的目的。

注意，如果目标对象自身的某个属性，不可写且不可配置，那么set方法将不起作用。

```javascript

const obj = {};
Object.defineProperty(obj, 'foo', {
  value: 'bar',
  writable: false,
});

const handler = {
  set: function(obj, prop, value, receiver) {
    obj[prop] = 'baz';
  }
};

const proxy = new Proxy(obj, handler);
proxy.foo = 'baz';
proxy.foo // "bar"

```

上面代码中，obj.foo属性不可写，Proxy 对这个属性的set代理将不会生效。

#apply()
`apply`方法拦截函数的调用、`call`和`apply`操作。
`apply`方法可以接受三个参数、分别是目标对象、目标对象的上下文对象(this)和目标对象的参数数组

```javascript

var target = function () { return 'I am the target'; };
var handler = {
  apply: function () {
    return 'I am the proxy';
  }
};

var p = new Proxy(target, handler);
p();

```
上面代码中，变量`p`是 Proxy 的实例，当它作为函数调用时（`p()`），就会被`apply`方法拦截，返回一个字符串。


#has()
`has`方法用来拦截HasProperty操作，即判断对象是否具有某个属性时，这个方法会生效。典型的操作就是`in`运算符。
`has`方法可以接受两个参数，分别是目标对象，需查询的属性名。

```javascript

var handler = {
  has (target, key) {
    if (key[0] === '_') {
      return false;
    }
    return key in target;
  }
};

var target = {_prop: 'foo', prop: 'foo'};
var proxy = new Proxy(target, handler);
'_prop' in proxy // false

```

上面的代码中，如果原对象的属性名的第一个字符是下划线，`proxy.has` 就会返回 `false`，从而不会被`in`运算符发现。
值得注意的是，`has`方法拦截的是`HasProperty`操作，而不是`HasOwnProperty`操作，即`has`方法不判断一个属性是对象自身的属性，还是继承的属性。
另外，虽然`for...in`循环也用到了`in`运算符，但是`has`拦截对`for...in`循环不生效。


```javascript

let stu1 = {name: '张三', score: 59};
let stu2 = {name: '李四', score: 99};

let handler = {
  has(target, prop) {
    if (prop === 'score' && target[prop] < 60) {
      console.log(`${target.name} 不及格`);
      return false;
    }
    return prop in target;
  }
}

let oproxy1 = new Proxy(stu1, handler);
let oproxy2 = new Proxy(stu2, handler);

'score' in oproxy1
// 张三 不及格
// false

'score' in oproxy2
// true

for (let a in oproxy1) {
  console.log(oproxy1[a]);
}
// 张三
// 59

for (let b in oproxy2) {
  console.log(oproxy2[b]);
}
// 李四
// 99

```

上面代码中，`has`拦截只对`in`运算符生效，对`for...in`循环不生效，导致不符合要求的属性没有被`for...in`循环所排除。

#construct()
`construct`方法用于拦截`new`命令，下面是拦截对象的写法。
```javascript

var handler = {
  construct (target, args, newTarget) {
    return new target(...args);
  }
};

```
`construct`方法可以接受两个参数。`target`：目标对象,`args`：构造函数的参数对象, `newTarget`：创造实例对象时，new命令作用的构造函数（下面例子的p）

```javascript

var p = new Proxy(function () {}, {
  construct: function(target, args) {
    console.log('called: ' + args.join(', '));
    return { value: args[0] * 10 };
  }
});

(new p(1)).value
// "called: 1"
// 10

```

`construct`方法返回的必须是一个对象，否则会报错。

```javascript

var p = new Proxy(function() {}, {
  construct: function(target, argumentsList) {
    return 1;
  }
});

new p() // 报错

```

#deleteProperty()
`deleteProperty`方法用于拦截`delete`操作，如果这个方法抛出错误或者返回`false`，当前属性就无法被`delete`命令删除。

```javascript

var handler = {
  deleteProperty (target, key) {
    invariant(key, 'delete');
    return true;
  }
};

function invariant (key, action) {
  if (key[0] === '_') {
    throw new Error(`Invalid attempt to ${action} private '${key}' property`);
  }
}

var target = { _prop: 'foo' };
var proxy = new Proxy(target, handler);
delete proxy._prop;
// Error: Invalid attempt to delete private "_prop" property
```
上面代码中，`deleteProperty`方法拦截了`delete`操作符，删除第一个字符为下划线的属性会报错。

注意，目标对象自身的不可配置（configurable）的属性，不能被`deleteProperty`方法删除，否则报错。


##  参考资料  ##
>
1. [主要参考的是阮一峰老是的文章](http://es6.ruanyifeng.com/#docs/proxy)
