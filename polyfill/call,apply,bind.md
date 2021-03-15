### call,apply, bind

先来说下call,apply,bind 的区别？

首先说下前二者的区别。
`call` 和 `apply`都是为了解决改变`this`的指向，作用都是相同的，只是传参方式不同。

- `call` 可以接收一个参数列表
- `apply` 可以接收一个参数数组

```javascript
let a = {
  value: 1,
};

function getValue(name, age) {
  console.log(name, age, this.value);
}

getValue.call(a, "rudy", "24");
getValue.call(a, ["rudy", "24"]);
```

模拟实现`call` 和 `apply`
可以从以下几点来考虑如何实现

- 不传入第一个参数，那么默认为`window`
- 改变`this`指向，让新的对象可以执行函数。那么思路是否可以变成给新的对象添加一个函数，然后再执行完后删掉？

```javascript
Function.prototype.myCall = function (ctx) {
  var ctx = ctx || window;
  // 给 ctx 添加一个属性
  // getValue.call(a, 'rudy', '24') => a.fn = getValue
  ctx.fn = this;
  // 将 ctx 后面的参数取出来
  var args = [...arguments].slice(1);
  // getValue.call(a, 'rudy', '24') => a.fn('yck', '24')
  var result = ctx.fn(...args);
  // 删除 fn
  delete ctx.fn;
  return result;
};
```

`apply` 的实现也很类似

```javascript
Function.prototype.myApply = function (ctx) {
  var ctx = ctx || window;
  ctx.fn = this;

  var result;
  if (arguments[1]) {
    result = ctx.fn(...arguments[1]);
  } else {
    result = ctx.fn();
  }

  delete ctx.fn;

  return result;
};
```

`bind` 和其他两个方法作用也是一致的，只是该方法会返回一个函数。并且我们可以通过 `bind` 实现柯里化。

同样的，也来模拟实现下 `bind`

```javascript
Function.prototype.myBind = function (ctx) {
  if (typeof this !== 'function') throw new TypeError('Error')

  let _this = this
  let args = [...arguments].slice(1)

  return function F () {
    // 这里需要加这个判断是因为,bind会返回一个函数,这个函数可以作为构造函数
    if (this instanceof F) {
      return new _this(...args, ...arguments)
    }
    // 这里参数需要拼接当前参数和绑定时传的参数
    return _this.apply(ctx, args.concat(...arguments))
  }
}
```

以上polyfill 都是基于ES5实现的,如果用ES6会更简单些.