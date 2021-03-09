1. ##### 对象转基本类型
对象在转换基本类型时，首先会调用 valueOf 然后调用 toString。并且这两个方法你是可以重写的。

```javascript

let a = {
    valueOf() {
    	return 0
    }
}

```
当然你也可以重写 Symbol.toPrimitive ，该方法在转基本类型时调用优先级最高。

```javascript

let a = {
  valueOf() {
    return 0;
  },
  toString() {
    return '1';
  },
  [Symbol.toPrimitive]() {
    return 2;
  }
}
1 + a // => 3
'1' + a // => '12'

```


2. ##### 四则运算符
只有当加法运算时，其中一方是字符串类型，就会把另一个也转为字符串类型。
其他运算只要其中一方是数字，那么另一方就转为数字。并且加法运算会触发三种类型转换：
将值转换为原始值，转换为数字，转换为字符串。

```javascript

1 + '1' // '11'
2 * '2' // 4
[1, 2] + [2, 1] // '1,22,1'
// [1, 2].toString() -> '1,2'
// [2, 1].toString() -> '2,1'
// '1,2' + '2,1' = '1,22,1'

```
对于加号需要注意这个表达式 `'a' + + 'b'`

```javascript
'a' + + 'b' // -> "aNaN"
// 因为 + 'b' -> NaN
// 你也许在一些代码中看到过 + '1' -> 1

```
3. ##### `==`操作符
![](./images/==操作符.png)

上图中的 `toPrimitive` 就是对象转基本类型。

这里来解析一道题目 `[] == ![] // -> true` ，下面是这个表达式为何为 true 的步骤

```javascript

// [] 转成 true，然后取反变成 false
[] == false
// 根据第 8 条得出
[] == ToNumber(false)
[] == 0
// 根据第 10 条得出
ToPrimitive([]) == 0
// [].toString() -> ''
'' == 0
// 根据第 6 条得出
0 == 0 // -> true

```

```javascript

string，number ==> number
boolean, 其他 ==> ToNumber(boolean)
Object，{string，number} ==> ToPrimitive(Object) == string|number

```

![](./images/proto.png)