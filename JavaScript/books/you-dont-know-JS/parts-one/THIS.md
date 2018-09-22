## this的全面解析 #

this 关键字是JavaScript 中最复杂的机制之一。this的绑定和函数声明的位置没有任何关系，只取决于函数的调用方式。

1. 调用位置

  在理解this的绑定过程之前，首先要理解调用位置：调用位置就是函数在代码中被调用的位置(而不是声明的位置)
  寻找调用位置最重要的是要分析调用栈(就是为了到达当前执行位置所调用的所有函数),调用位置就在当前正在执行的函数的前一个调用中。

  下面看看到底什么是调用栈和调用位置：

  ```javascript

  function baz() {
    // 当前调用栈是：baz
    // 因此, 当前调用位置是全局作用域

    console.log('baz');
    bar();  // bar的调用位置
  }

  function bar() {
    // 当前调用栈是 baz -> bar
    // 因此，当前调用位置在baz 中

    console.log('bar');
    foo(); // foo的调用位置
  }

  function foo() {
    // 当前的调用栈是 baz -> bar -> foo
    // 因此，当前调用位置在bar中

    console.log('foo');
  }

  baz(); // baz的调用位置

  ```

2. 绑定规则

  2.1 默认绑定

    首先介绍的是最常用的函数调用类型：独立函数调用。

    ```javascript

    function foo() {
      // 当前调用栈是：foo
      // 因此, 当前调用位置是全局作用域
      console.log(this.a);
    }

    var a = 2;

    foo(); // 2

    ```
    此处函数调用时应用了this的默认绑定，因此this指向全局对象，那我们怎么知道这里应用了默认绑定呢？这里可以通过分析调用位置
    来看看foo() 是如何调用的。在代码中，foo() 是直接使用不带任何修饰的函数引用进行调用的，因此只能使用默认绑定，无法应用其他规则。

    PS:
    如果使用严格模式 (strict mode),则不能将全局对象用于默认绑定，因此this 会绑定到`undefined`:

    ```javascript
    
    function foo() {
      'use strict';
      console.log(this) // undefined
      console.log(this.a);
    }

    var a = 2;

    foo(); // Uncaught TypeError: Cannot read property 'a' of undefined
    
    ```

    此处有一个微妙但是非常重要的细节，虽然this的绑定规则完全取决于调用位置，但是只有foo() 运行在非 strict mode下时，默认绑定才能全局对象；
    在严格模式下调用 foo() 则不影响默认绑定;

    ```javascript
    
    function foo() {
      console.log(this.a)
    }

    var a = 2;

    (function () {
      'use strict';

      foo(); // 2
    }());
    
    ```

  2.2 隐式绑定

    另一条需要考虑得规则是调用位置是否有上下文对象，或者说是否被某个对象拥有或者包含，不过这种说法可能会造成一些误导。
    
    思考下面的代码：

    ```javascript
    
    function foo() {
      console.log(this.a);
    }
    
    var obj = {
      a: 2,
      foo: foo
    }

    obj.foo(); // 2
    ```

    首先需要注意的是foo() 的声明方式，及其之后是如何被当作引用属性添加到obj中的。
    但是无论是直接在obj中定义还是先定义后添加为引用属性，这个函数严格上来说都不属于obj对象。
    
    然而，调用位置会使用obj上下文来引用函数，因此你可以说函数被调用时obj对象 “拥有” 或者 “包含” 它。

    无论你如何称呼这个模式，当foo()被调用时，它的前面确实加上了对obj的引用。当函数引用有上下文对象时，隐式绑定规则会把函数调用
    中的this绑定到这个上下文对象。因为调用foo()时 this 被绑定到obj，因此this.a 和 obj.a 是一样的。

    对象属性引用链中只有上一层或者说最后一层在调用位置中起作用。看下例：

    ```javascript

     function foo() {
       console.log(this.a)
     }

     var obj2 = {
       a: 42,
       foo: foo
     }

     var obj1 = {
       a: 2,
       obj2: obj2
     }

     obj1.obj2.foo(); // 42

    ```

    隐式丢失

    一个常见的this绑定问题就是被隐式绑定的函数会丢失绑定对象，也就是说它会应用默认绑定，从而把this绑定到全局对象
    或者undefined上，取决于是否是严格模式。

    思考下面的代码：

    ```javascript
    
    function foo() {
      console.log(this.a);
    }

    var obj = {
      a: 2,
      foo: foo
    }

    var bar = obj.foo // 函数别名
    
    var a = 'oops, global'

    bar(); // 'oops global'
    
    ```

    虽然bar是obj.foo的一个引用，但是实际上，它引用的是foo函数本身，因此此时的bar()其实是一个不带任何修饰
    的函数调用，因此应用了默认绑定。

    一种更微妙、常见并且更出乎意料的情况发生在传入回调函数时：

    ```javascript
    
    function foo() {
      console.log(this.a);
    }

    function doFoo(fn) {
      // fn 其实引用的是 foo

      fn();
    }

    var obj = {
      a: 2,
      foo: foo
    }

    var a = 'oops, global' // a 是全局对象的属性

    doFoo(obj.foo)  // 'oops, global'
    
    ```
    参数传递其实就是一种隐式赋值，因此我们传入函数时也会被隐式赋值。

    如果把函数传入语言内置的函数而不是传入你自己声明的函数，会发生什么呢？结果是一样的，没有区别：

    ```javascript
    
    function foo() {
      console.log(this.a)
    }

    var obj = {
      a: 2,
      foo: foo
    }

    var a = 'oops, global'

    setTimeout(obj.foo, 100) // 'oops, global'
    
    ```