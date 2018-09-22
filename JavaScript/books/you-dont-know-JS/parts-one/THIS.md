## this的全面解析 #

this 关键字是JavaScript 中最复杂的机制之一。this的绑定和函数声明的位置没有任何关系，只取决于函数的调用方式。

1. 调用位置

在理解this的绑定过程之前，首先要理解调用位置：调用位置就是函数在代码中被调用的位置(而不是声明的位置)
寻找调用位置最重要的是要分析调用栈(就是为了到达当前执行位置所调用的所有函数),调用位置就在当前正在执行的函数的前一个调用中。

下面看看到底什么是调用栈和调用位置：

```javascript

function baz() {
  当前调用栈是：baz
  因此, 当前调用位置是全局作用域

  console.log('baz');
  bar();  bar的调用位置
}

function bar() {
  当前调用栈是 baz -> bar
  因此，当前调用位置在baz 中

  console.log('bar');
  foo();  foo的调用位置
}

function foo() {
  当前的调用栈是 baz -> bar -> foo
  因此，当前调用位置在bar中

  console.log('foo');
}

baz(); baz的调用位置

```

2. 绑定规则

2.1 默认绑定

首先介绍的是最常用的函数调用类型：独立函数调用。

```javascript

function foo() {
  console.log(this.a);
}

var a = 2;

foo(); // 2

```