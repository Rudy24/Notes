每个执行上下文,都有三个重要属性：
1. 变量对象(Variable object, VO);
2. 作用域链(Scope chain);
3. this

变量对象：存储了在上下文中定义的变量和函数声明。

在函数上下文中，我们用活动对象(activation object, AO)来表示变量对象。
活动对象和变量对象其实是一个东西，只是变量对象是规范上的或者说是引擎实现上的，不可在 JavaScript 环境中访问，只有到当进入一个执行上下文中，这个执行上下文的变量对象才会被激活，所以才叫 activation object 呐。

变量对象(VO) 和 活动对象(AO)的区别：
未进入执行阶段之前，变量对象(VO)中的属性都不能访问！但是进入执行阶段之后，变量对象(VO)转变为了活动对象(AO)，里面的属性都能被访问了，然后开始进行执行阶段的操作。

`AO = VO + function parameters + arguments`
**它们其实都是同一个对象，只是处于执行上下文的不同生命周期。**

执行过程
执行上下文的代码会分成两个阶段进行处理：分析和执行，我们也可以叫做：
1. 进入执行上下文。
2. 代码执行。

进入执行上下文
当进入执行上下文时，这时候还没有执行代码，
变量对象会包括：

1. 函数的所有形参 (如果是函数上下文)
    - 由名称和对应值组成的一个变量对象的属性被创建
    - 没有实参，属性值设为undefined
2. 函数声明
    - 由名称和对应值(函数对象(function-object))组成一个变量对象的属性被创建。
    - **如果变量对象已经存在相同名称的属性，则完全替换这个属性。**
3. 变量声明
    - 由名称和对应值（undefined）组成一个变量对象的属性被创建。
    - **如果变量名称跟已经声明的形式参数或函数相同，则变量声明不会干扰已经存在的这类属性。**