### Vue.js异步更新DOM策略及nextTick

<!-- 1. Vue.js异步更新DOM策略及nextTick 讲了什么？
    - asdf
2. Vue.js异步更新DOM策略及nextTick 怎么实现的？
3. Vue.js异步更新DOM策略及nextTick 得到了什么？ -->

1. Vue为什么要采用异步更新策略？
    - Vue更新DOM的流程是：在某个响应式数据发生变化时，它的setter函数会通知闭包中的Dep，Dep则会调用它管理的所有Watch对象，触发Watch对象的update实现更新DOM，这里看下update的实现, Vue默认时使用异步更新，当异步执行update的时候，会调用`queueWatcher`函数。

    - 如果Vue不采用异步策略又会发生什么呢？现在有这样一个场景，mounted的时候，某个属性值会被循环执行1000次，每次执行的时候，都会根据响应式触发setter--->Dep--->Watch--->update--->patch，每次都会直接操作DOM更新视图，这是非常消耗性能的，因此Vue采用queue队列去实现异步更新。同时，拥有相同id的Watcher不会被重复加入到该queue中去，所以不会执行1000次Watcher的run。最终更新视图只会直接将test对应的DOM的0变成1000。 保证更新视图操作DOM的动作是在当前栈执行完以后下一个tick的时候调用，大大优化了性能。

```javascript

update () {
  if (this.lazy) {
    this.dirty = true;
  } else if (this.sync) {
    // 同步则执行run直接渲染视图
    this.run()
  } else {
    // 异步推送到观察者对象中，下一个tick时调用
    queueWatcher(this);
  }
}

```

2. Vue怎么去实现异步更新的呢？

```javascript

// 将一个观察者对象push进观察者队列，在队列中已经存在的id则该观察者对象将被跳过，除非它是在队列被刷新时推送的
function queueWatcher(watcher) {
  // 获取watcher的id
  const { id } = watcher;
  // 检测id是否存在？已经存在则直接跳过，不存在则标记哈希表has，用于下次检测
  if (has[id] == null) {
    has[id] = true
    if (!flushing) {
      // 如果没有flush掉，直接push到队列中即可
      queue.push(watcher)
    } else {
      let i = queue.length - 1
      while (i >= 0 && queue[i].id > watcher.id) {
        i--
      }
      queue.splice(Math.max(i, index) + 1, 0, watcher)
    }
    // queue the flush
    if (!waiting) {
      waiting = true;
      nextTick(flushSchedulerQueue);
    }
  }
}

```
查看queueWatcher的源码我们发现，Watch对象并不是立即更新视图，而是被push进一个队列queue，此时状态处于waiting的状态，这时候会继续有Watch对象被push进这个队列queue，等到下一个tick运行时，这些Watch对象才会被遍历取出，更新视图。同时，id重复的Watcher不会被多次加入到queue中去，因此在最终渲染时，我们只需要关心数据的最终结果。

上面源码可以看出最后调用了`nextTick`去实现，那`nextTick`是什么呢？

```javascript


/**
 * Defer a task to execute it asynchronously.
 */
 /*
    延迟一个任务使其异步执行，在下一个tick时执行，一个立即执行函数，返回一个function
    这个函数的作用是在task或者microtask中推入一个timerFunc，在当前调用栈执行完以后以此执行直到执行到timerFunc
    目的是延迟到当前调用栈执行完以后执行
*/
export const nextTick = (function () {
  /*存放异步执行的回调*/
  const callbacks = []
  /*一个标记位，如果已经有timerFunc被推送到任务队列中去则不需要重复推送*/
  let pending = false
  /*一个函数指针，指向函数将被推送到任务队列中，等到主线程任务执行完时，任务队列中的timerFunc被调用*/
  let timerFunc

  /*下一个tick时的回调*/
  function nextTickHandler () {
    /*一个标记位，标记等待状态（即函数已经被推入任务队列或者主线程，已经在等待当前栈执行完毕去执行），这样就不需要在push多个回调到callbacks时将timerFunc多次推入任务队列或者主线程*/
    pending = false
    /*执行所有callback*/
    const copies = callbacks.slice(0)
    callbacks.length = 0
    for (let i = 0; i < copies.length; i++) {
      copies[i]()
    }
  }
  /*
    这里解释一下，一共有Promise、MutationObserver以及setTimeout三种尝试得到timerFunc的方法
    优先使用Promise，在Promise不存在的情况下使用MutationObserver，这两个方法都会在microtask中执行，会比setTimeout更早执行，所以优先使用。
    如果上述两种方法都不支持的环境则会使用setTimeout，在task尾部推入这个函数，等待调用执行。
    参考：https://www.zhihu.com/question/55364497
  */
  if (typeof Promise !== 'undefined' && isNative(Promise)) {
    /*使用Promise*/
    var p = Promise.resolve()
    var logError = err => { console.error(err) }
    timerFunc = () => {
      p.then(nextTickHandler).catch(logError)
    }
  } else if (typeof MutationObserver !== 'undefined' && (
    isNative(MutationObserver) ||
    MutationObserver.toString() === '[object MutationObserverConstructor]'
  )) {
    /*新建一个textNode的DOM对象，用MutationObserver绑定该DOM并指定回调函数，在DOM变化的时候则会触发回调,该回调会进入主线程（比任务队列优先执行），即textNode.data = String(counter)时便会触发回调*/
    var counter = 1
    var observer = new MutationObserver(nextTickHandler)
    var textNode = document.createTextNode(String(counter))
    observer.observe(textNode, {
      characterData: true
    })
    timerFunc = () => {
      counter = (counter + 1) % 2
      textNode.data = String(counter)
    }
  } else {
    // fallback to setTimeout
    /* istanbul ignore next */
    /*使用setTimeout将回调推入任务队列尾部*/
    timerFunc = () => {
      setTimeout(nextTickHandler, 0)
    }
  }

  /*
    推送到队列中下一个tick时执行
    cb 回调函数
    ctx 上下文
  */
  return function queueNextTick (cb, ctx) {
    let _resolve
    /*cb存到callbacks中*/
    callbacks.push(() => {
      if (cb) {
        try {
          cb.call(ctx)
        } catch (e) {
          handleError(e, ctx, 'nextTick')
        }
      } else if (_resolve) {
        _resolve(ctx)
      }
    })
    if (!pending) {
      pending = true
      timerFunc()
    }
    if (!cb && typeof Promise !== 'undefined') {
      return new Promise((resolve, reject) => {
        _resolve = resolve
      })
    }
  }
})()

```

它是一个立即执行函数,返回一个queueNextTick接口。

传入的cb会被push进callbacks中存放起来，然后执行timerFunc（pending是一个状态标记，保证timerFunc在下一个tick之前只执行一次）。

timerFunc是什么？

看了源码发现timerFunc会检测当前环境而不同实现，其实就是按照Promise，MutationObserver，setTimeout优先级，哪个存在使用哪个，最不济的环境下使用setTimeout。

这里解释一下，一共有Promise、MutationObserver以及setTimeout三种尝试得到timerFunc的方法。 优先使用Promise，在Promise不存在的情况下使用MutationObserver，这两个方法的回调函数都会在microtask中执行，它们会比setTimeout更早执行，所以优先使用。 如果上述两种方法都不支持的环境则会使用setTimeout，在task尾部推入这个函数，等待调用执行。

为什么要优先使用microtask？我在顾轶灵在知乎的回答中学习到：

> JS 的 event loop 执行时会区分 task 和 microtask，引擎在每个 task 执行完毕，从队列中取下一个 task 来执行之前，会先执行完所有 microtask 队列中的 microtask。
setTimeout 回调会被分配到一个新的 task 中执行，而 Promise 的 resolver、MutationObserver 的回调都会被安排到一个新的 microtask 中执行，会比 setTimeout 产生的 task 先执行。
要创建一个新的 microtask，优先使用 Promise，如果浏览器不支持，再尝试 MutationObserver。
实在不行，只能用 setTimeout 创建 task 了。
**为啥要用 microtask？
根据 HTML Standard，在每个 task 运行完以后，UI 都会重渲染，那么在 microtask 中就完成数据更新，当前 task 结束就可以得到最新的 UI 了。
反之如果新建一个 task 来做数据更新，那么渲染就会进行两次。**
参考顾轶灵知乎的回答：https://www.zhihu.com/question/55364497/answer/144215284
tips: Vue 的 nextTick 实现移除了 MutationObserver 的方式（兼容性原因），取而代之的是使用 MessageChannel


首先是Promise，Promise.resolve().then()可以在microtask中加入它的回调，

MutationObserver新建一个textNode的DOM对象，用MutationObserver绑定该DOM并指定回调函数，在DOM变化的时候则会触发回调,该回调会进入microtask，即textNode.data = String(counter)时便会加入该回调。

setTimeout是最后的一种备选方案，它会将回调函数加入task中，等到执行。

综上，nextTick的目的就是产生一个回调函数加入task或者microtask中，当前栈执行完以后（可能中间还有别的排在前面的函数）调用该回调函数，起到了异步触发（即下一个tick时触发）的目的。

最上面flushSchedulerQueue是下一个tick时的回调函数，主要目的是执行Watcher的run函数，用来更新视图

```javascript

/**
 * Flush both queues and run the watchers.
 */
 /*nextTick的回调函数，在下一个tick时flush掉两个队列同时运行watchers*/
function flushSchedulerQueue () {
  flushing = true
  let watcher, id
  /*
    给queue排序，这样做可以保证：
    1.组件更新的顺序是从父组件到子组件的顺序，因为父组件总是比子组件先创建。
    2.一个组件的user watchers比render watcher先运行，因为user watchers往往比render watcher更早创建
    3.如果一个组件在父组件watcher运行期间被销毁，它的watcher执行将被跳过。
  */
  queue.sort((a, b) => a.id - b.id)

  /*这里不用index = queue.length;index > 0; index--的方式写是因为不要将length进行缓存，因为在执行处理现有watcher对象期间，更多的watcher对象可能会被push进queue*/
  for (index = 0; index < queue.length; index++) {
    watcher = queue[index]
    id = watcher.id
    /*将has的标记删除*/
    has[id] = null
    /*执行watcher*/
    watcher.run()
  }
}


```