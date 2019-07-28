
Promise 是一种异步编程解决方案

Promise 有以下两个特点。
1. 对象的状态不受外界影响，Promise对象代表一个异步操作，有三种状态：padding(进行中)、fulfilled(已成功) 和 rejected(已失败)。只有异步操作的结果，可以决定当前是那种状态，任何其他操作都无法改变这个状态。
2. 一旦状态改变，就不会再变，任何时候都可以得到这个结果。Promise对象的状态改变，只有两种可能：从pending => fulfilled 和 pending => rejected。只要这两种情况发生，状态就凝固了，不会再变，会一直保持这个状态，这时称为 resolved (已定性)

基本用法
Promise对象是一个构造函数，用来生成Promise实例
```javascript
const promise = new Promise((resolve, reject) => {
  if (true) {
    resolve(value)
  } else {
    reject(error)
  }
})
```

Promise 构造函数接受一个函数作为参数，该函数的两个参数分别为resolve 和 reject。 它们是两个函数，由JavaScript引擎提供，不需要自己部署
resolve函数的作用是，将Promise对象的状态从 '未完成' 变为 '成功' (即pending 变为 resolved)。 在异步操作成功时调用，并将异步操作的结果 作为参数传递出去
reject函数的作用是，将Promise对象的状态从 '未完成' 变为 '失败'(即pending 变为 rejected)，在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。
Promise实例生成以后，可以用then方法分别指定resolved状态和rejected状态的回调函数

```javascript
promise.then((value) => {
  // success
}, (error) => {
  // failure
})
```

then方法可以接受两个回调函数作为参数，第一个回调函数是Promise对象的状态变为resolved时调用，第二个回调函数是Promise对象的状态为rejected时调用，第二个回调可选

```javascript
var promise = new Promise((resolve, reject) => {
  console.log('Promise');
  resolve();
});

promise.then(() => {
  console.log('resolve');
});

console.log('hi');

// Promise
// hi
// resolve

```

上面代码中，Promise新建后立即执行，所以先输出的是Promise。然后，then方法制定的回调函数，将在当前脚本所有同步任务执行完才会执行，所以resolved最后执行，【如果不写resolve()，就不会输出'resolve'】


Promise.prototype.finally
`finally`方法用于指定不管Promise对象最后的状态如何，都会执行的操作，该方法是ES2018引入标准的，`finally`方法的回调函数是不接受任何参数，意味着前面Promise状态到底是resolve or rejected。表明 `finally`方法里面的操作，应该是与状态无关的，不依赖于Promise的执行结果。

```javascript

var promise = new Promise((resolve, reject) => {
    return resolve(111);
  }).then(res => {
      console.log(res);
  }).catch(error => {
      console.error(error)
  }).finally(() => {
      console.log('finally');
  })

  // 111
  // finally

```

Promise.all()
`Promise.all`方法用于将多个Promise 实例，包装成一个新的Promise实例

```javascript  
javascript const p = Promise.all([p1, p2, p3]);

```
`p`的状态由`p1`、`p2`、`p3`决定，分成两种情况。
1. 只有 `p1`、`p2`、`p3`的状态都变成`fulfilled`， `p`的状态才会变成`fulfilled`，此时`p1`、`p2`、`p3`的返回值组成一个数组，传递给`p`的回掉函数。
2. 只要 `p1`、`p2`、`p3`之中有一个被`rejected`， `p`的状态就变成了`rejected`，此时第一个被`reject`的实例的返回值，会传递给`p`的回调函数。

```javascript

const p1 = new Promise((resolve, reject) => {
  resolve('hello');
})
.then(result => result);

const p2 = new Promise((resolve, reject) => {
  throw new Error('报错了');
})
.then(result => result);

Promise.all([p1, p2])
.then(result => console.log(result))
.catch(e => console.log(e));
// Error: 报错了


```

Promise.race
`Promise.race()`方法同样是将多个Promise实例，包装成一个新的Promise实例。
```javascript

const p = Promise.race([p1, p2, p3])

```

上面代码中，只要`p1`、`p2`、`p3`之中有一个实例率先改变状态，`p`的状态就跟着改变。那个率先改变的 Promise 实例的返回值，就传递给`p`的回调函数。

`Promise.race`方法的参数与`Promise.all`方法一样，如果不是 Promise 实例，就会先调用下面讲到的`Promise.resolve`方法，将参数转为 Promise 实例，再进一步处理。

```javascript

const p = Promise.race([
  fetch('/resource-that-may-take-a-while'),
  new Promise(function (resolve, reject) {
    setTimeout(() => reject(new Error('request timeout')), 5000)
  })
]);

p
.then(console.log)
.catch(console.error);

```
上面代码中，如果 5 秒之内`fetch`方法无法返回结果，变量`p`的状态就会变为`rejected`，从而触发`catch`方法指定的回调函数。
