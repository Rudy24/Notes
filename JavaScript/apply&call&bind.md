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

#apply 和 call 的用法
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

# apply 和 call的实现方式

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