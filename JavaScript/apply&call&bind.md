# apply, call 
什么是apply，call 方法：
apply()，call() 方法调用一个函数, 其具有一个指定的this值，以及作为一个数组（或类似数组的对象）提供的参数。
换句话说，就是为了改变函数体内部 this 的指向。

# apply()
`apply`方法传入两个参数：1.作为函数上下文的对象，2.作为函数参数所组成的数组。

```javascript
var obj = {
  name: 'rudy'
};

function func(fname, lname) {
  console.log(`${fname} ${this.name} ${lname}`);
}

func.apply(obj, ['hello', 'world']); // hello rudy world;

```
可以看出，`obj`作为函数上下文的对象，函数`func`中的`this`指向了`obj`对象，`['hello', 'world'] `是放在数组中传入`func`函数，对应`func`参数列表

# call()
`call`方法跟`apply`方法基本一致，区别在于提供的参数是一个列表，并非单个数组。

```javascript

var obj = {
  name: 'rudy'
};

function func(fname, lname) {
  console.log(`${fname} ${this.name} ${lname}`);
}

func.call(obj, 'hello', 'world'); // hello rudy world

```

至于什么时候用`call` 或 `apply`,如果你的参数为数组，就用`apply`，如果参数比较零散，就用`call`

# apply 和 call 的用法
1. 改变 this 的指向
```javascript

var obj = {
  name: 'rudy'
};

function func() {
  console.log(this.name);
}

func.call(obj); // rudy


```

我们知道，`call` 方法的第一个参数是作为函数上下文的对象，这里把 `obj` 作为参数传给了 `func`，此时函数里的 `this` 便指向了 `obj` 对象。此处 `func` 函数里其实相当于

```javascript

function func() {
    console.log(obj.name);
}

```
2. 借用别的对象方法

```javascript

var Person1 = function () {
  this.name = 'rudy';
};
var Person2 = function () {
  this.getname = function () {
    console.log(this.name);
  };
  Person1.call(this);
}

var person = new Person2();

person.getname(); // rudy

```

从上面我们看到，`Person2` 实例化出来的对象 `person` 通过 `getname` 方法拿到了 `Person1` 中的 `name`。因为在 `Person2` 中，`Person1.call(this)` 作用就是借用`Person1`的方法并且把`this`指向`Person2`，那么 `Person2 `就有了 `Person1` 中的所有属性和方法了，相当于 `Person2` 继承了 `Person1` 的属性和方法。

3. 调用函数
`apply,call`方法都会使函数立即执行，因此它们也可以用来调用函数。
```javascript

function func() {
  console.log('rudy');
}
func.call(); // rudy

function func () {
  console.log(arguments);
}

func.call(null, 'A', 'B');  // 输入 A,B

```

# 为了巩固加深记忆，下面列举一些常用用法：

1. 数组之间的追加
```javascript

var arr1 = [1,2,3];
var arr2 = ['a', 'b', 'c'];

Array.prototype.push.apply(arr1, arr2); // [1, 2, 3, "a", "b", "c"]

```
2. 获取数组中的最大值和最小值
```javascript

var num = [1,10,20];
var maxNum = Math.max.apply(Math, num), // 20
    maxNum = Math.max.call(Math, 1,10, 20); // 20

```
`num` 本身没有`max`方法，但`Math`有，我们可以借助`call`或者`apply`使用其方法。

3. 验证是否是数组（前提是toString()方法没有被重写过）
```javascript

function isArray(arr) {
  return Object.prototype.toString.call(arr).slice(8, -1).toLowerCase() === 'array';
}
或者
function isArray(arr) {
  return Object.prototype.toString.call(arr) === '[object Array]';
}

```
4. 类（伪）数组使用数组方法

```javascript

var domNodes = Array.prototype.slice.call(document.getElementsByTagName('*'));

Javascript中存在一种名为伪数组的对象结构。比较特别的是 `arguments` 对象，还有像调用 `getElementsByTagName` , `document.childNodes` 之类的，它们返回 `NodeList` 对象都属于伪数组。不能应用 Array下的 `push` , `pop` 等方法。
但是我们能通过  `Array.prototype.slice.call`  转换为真正的数组的带有 `length` 属性的对象，这样 `domNodes` 就可以应用 `Array` 下的所有方法了。

```

# bind
什么是 bind：
> bind() 方法会创建一个新函数。当这个新函数被调用时，bind() 的第一个参数将作为它运行时的 this，
> 之后的一序列参数将会在传递的实参前传入作为它的参数。(来自于 MDN )

由此我们可以得出`bind`函数的两个特点：
 1. 会返回一个函数
 2. 可以传入参数

请看例子：

在常见的单体模式中，通常我们会使用 `var self = this`等保存 `this`，这样我们可以在改变了上下文之后，继续引用它。 例如

```javascript
建立个方法，输出foo内的name值
var name = 'kobe';
var foo = {
  name: 'rudy',
  eBind: function () {
    return (function () {
      console.log(this.name)
    })()
  }
}

foo.eBind(); // kobe

这里与我们想要的结果不一致，我们改下

var foo = {
  name: 'rudy',
  eBind: function () {
    var self = this;
    return (function () {
      console.log(self.name)
    })()
  }
}

foo.eBind(); // rudy

```
最后就得到了想要的结果，当然使用bind() 也可以更好的解决这个问题。

```javascript
var name = 'kobe'
var foo = {
  name: 'rudy',
  eBind: function () {
    return (function () {
      console.log(this.name)
    }).bind(this)()
  }
}

foo.eBind(); // rudy

``` 

# apply、call、bind比较

那么 `apply`、`call`、`bind` 三者相比较，之间又有什么异同呢？何时使用 `apply`、`call`，何时使用 `bind` 呢。简单的一个栗子：

```javascript

var obj = {
  value: 11
};

var foo = {
  getValue: function () {
    return this.value;
  }
};

foo.getValue.call(obj); // 11
foo.getValue.apply(obj); // 11
foo.getValue.bind(obj)(); // 11

```
三个都是输出11，但在使用`bind()` 的时候，后面多了对括号，`这是因为调用了bind，它返回的是函数`，所以需要在执行一次才能得到结果。


# 再总结一下：

1. apply 、 call 、bind 三者都是用来改变函数的this对象的指向的；
2. apply 、 call 、bind 三者第一个参数都是this要指向的对象，也就是想指定的上下文；
3. apply 、 call 、bind 三者都可以利用后续参数传参；
4. bind 是返回对应函数，便于稍后调用；apply 、call 则是立即调用。


# apply 和 call、bind的实现方式

# call
```javascript

Function.prototype.call = function (context, ...args) {
  var context = context || window;
  context.fn = this;
  var result = context.fn(...args);
  delete context.fn;
  return result;
}

```

# apply
```javascript

Function.prototype.apply = function (context, args) {
  context = Object(context) || window;
  context.fn = this;

  var result;
  if (!args) {
    return result = context.fn();
  }
  result = context.fn(...args);
  delete context.fn;
  return result;
}

```

# bind
```javascript

Function.prototype.bind = function (context) {
  // 调用 bind的必须是函数
  if (typeof this !== 'function') {
    throw new Error('Function.prototype.bind - what is trying tobe bound is not callable');
  }

  var self = this;
  // 获取第二个到最后一个的参数
  var args = Array.prototype.slice.call(arguments, 1); 

  var fNOP = function () {};

  var fBound = function () {
    // 这个arguments跟上面的arguments不一样，这个是绑定后 返回函数arguments
    var bindArgs = Array.prototype.slice.call(arguments);
    return self.apply(this instanceof fNOP ? this : context, args.concat(bindArgs));
  }

  fNOP.prototype = this.prototype;
  fBound.prototype = new fNOP();
  return fBound;
}

```

# PS: 
> 1. 以上apply，call实现过程请参考 (https://github.com/mqyqingfeng/Blog/issues/11)
> 2. 以上bind实现过程请参考 (https://github.com/mqyqingfeng/Blog/issues/12)

##  参考资料  ##
>
1. [JavaScript 中 apply 、call 的详解](https://github.com/lin-xin/blog/issues/7)
2. [深入浅出 妙用Javascript中apply、call、bind](https://www.cnblogs.com/coco1s/p/4833199.html)
3. [JavaScript深入之call和apply的模拟实现](https://github.com/mqyqingfeng/Blog/issues/11)
4. [JavaScript深入之bind的模拟实现](https://github.com/mqyqingfeng/Blog/issues/12)