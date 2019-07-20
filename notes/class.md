## 类

es6 引入的 class 类实质上是 JavaScript 基于原型的继承的语法糖。

```javascript
function Animal(name) {
  this.name = name;
}

Animal.prototype.sayHi = () => {
  return `Hello ${this.name}`;
};

// 等同于

class Animal {
  constructor(name) {
    this.name = name;
  }

  sayHi() {
    return `Hello ${this.name}`;
  }
}
```

类由两部分组成：类声明，类表达式

1. 类声明

```javascript
class Animal {
  constructor(name) {
    this.name = name;
  }
}
```

类实际上是个`特殊的函数`，普通函数声明和类函数声明有一个重要的区别就是函数
声明会提升，而类声明不会。如果先访问，后声明就会抛出类似于下面的错误。

```javascript
let animal = new Animal();
// Uncaught ReferenceError: Cannot access 'Person' before initialization

class Animal {}
```

2. 类表达式

类表达式可以是被命名的或匿名的，(ps: 类表达式也同样受到类声明中提到的提升问题的困扰。)

```javascript
// 匿名类
let Animal = class {
  constructor(name) {
    this.name = name;
  }
};

// 命名类
let Animal = class Animal {
  constructor(name) {
    this.name = name;
  }
};
```

3. 构造函数
   `constructor`方法是类的默认方法，通过`new`创建对象实例时，自动会调用该方法，
   一个类必须拥有`constructor`方法，如果没有写，JavaScript 引擎会默认加上空的`constructor`方法。

```javascript
class Animal {}

// 等同于

class Animal {
  constructor() {}
}
```

4. 严格模式
   类和模块的内部，默认就是严格模式，比如，构造函数，静态方法，原型方法，getter 和 setter 都在严格模式下执行。

5. 类的实例
   类的实例，通过 new 创建, 创建时会自动调用构造函数

```javascript
class Animal {
  constructor(name) {
    this.name = name;
  }

  sayHi() {
    return "My name is " + this.name;
  }
}

let animal = new Animal("rudy");
animal.sayHi(); // My name is rudy
```

6. 存取器
   与 ES5 一样，在类的内部可以使用`get`和`set`关键字，对某个属性设置存取
   函数和取值函数，拦截该属性的存取行为。

```javascript
class Animal {
  constructor(name) {
    this.name = name;
  }

  get name() {
    return "rudy";
  }

  set name(value) {
    console.log("setter, " + this.value);
  }
}

let animal = new Animal("rudy");
animal.name = "Tom"; // setter, Tom
console.log(a.name); // rudy
```

7. 静态方法
   使用`static`修饰符修饰的方法称为静态，它们不需要实例化，直接通过类来调用。

```javascript
class Animal {
  static sayHi(name) {
    console.log("i am " + name);
  }
}

let animal = new Animal();
Animal.sayHi("rudy"); // i am rudy
animal.sayHi("rudy"); // Uncaught TypeError: animal.sayHi is not a function
```

8. 实例属性，静态属性
   ES6 中的实例属性只能通过构造函数中的`this.xxx`来定义，但最近 ES7 中可以直接在类里面定义：

```javascript
class Animal {
  name = "rudy";
  static value = 11;
  sayHi() {
    console.log(`hello, ${this.name}`);
  }
}

let animal = new Animal();
animal.sayHi(); // hello, rudy
Animal.value; // 11
animal.value; // undefiend
```

9. 类的继承
   使用`extends`关键字实现继承，子类中使用`super`关键字来调用父类的构造函数和方法。

```javascript
class Animal {
  constructor(name) {
    this.name = name;
  }

  sayHi() {
    return "this is " + this.name;
  }
}

class Cat extends Animal {
  constructor(name, value) {
    super(name); // 调用父类的 constructor(name)
    this.value = value;
  }

  sayHi() {
    return `omg, ${super.sayHi()} it is ${this.value}`;
  }
}

let cat = new Cat("Tom", 11);
cat.sayHi(); // omg, this is Tom it is 11;
```
