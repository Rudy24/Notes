### for of 和 for in

#### for of
`for of`语句在可迭代对象(包括`Array`, `Map`, `Set`, `String`, `TypedArray`, `arguments`对象等)上船舰一个迭代循环，调用自定义迭代钩子，并未每个不同属性的值执行语句。

```javascript
// 迭代Array
const array1 = [10, 20, 30]

for (const value of array1) {
  console.log(value)
}
// 10, 20, 30

// 迭代String
const str = 'abcd'
for (const value of str) {
  console.log(value)
}
// a, b, c, d

// 迭代TypedArray
const tArr = new Uint8Array([0x00, 0xff])

for (const value of tArr) {
  console.log(value)
}
// 0, 255

// 迭代Map
const map = new Map([['a', 1], ['b', 2], ['c', 3]])

for (const value of map) {
  console.log(value)
}

// ['a', 1], ['b', 2], ['c', 3]

for (const [key, value] of map) {
  console.log(value)
}

// 1,2,3

// 迭代Set
const set = new Set([1, 1, 2, 2, 3, 3])
for (const value of set) {
  console.log(value)
}

// 1，2，3

// 迭代arguments对象
(function() {
  for (const argument of arguments) {
    console.log(argument)
  }
})(1,2,3)

// 1,2,3

// 关闭迭代器，对于for...of的循环，可以由break，throw，continue 或 return 终止，这些情况下，迭代器关闭。

function* foo () {
  yield 1;
  yield 2;
  yield 3;
}

for (const o of foo()) {
  console.log(o)
  if (o === 1) break
}

// 1


```

#### for in
`for in`语句以任意顺序遍历一个对象的除`Symbol`以外的可枚举属性, 会遍历到继承的属性。

```javascript

const o = { a: 1, b: 2, c: 3, d: 4 }

for (const key in o) {
  console.log(k)
}

// a, b, c, d
Object.prototype.name = 'color'
const o1 = { a: 1, b: 2, c: 3 }

for (const k in o1) {
  console.log(k)
}

// a, b, c, name

// 如果想只遍历自身的属性，则可以加上hasOwnProperty

for (const k in o1) {
  if (o1.hasOwnProperty(k)) {
    console.log(k)
  }
}

// a,b,c

```

#### for...of 和 for...in的区别？
1. for...of 遍历value，for...in遍历key
2. for...of 只会遍历自有属性，for...in不仅会遍历自有属性而且会遍历继承属性，除非加`hasOwnProperty`去除。

```javascript

Object.prototype.objCustom = function() {};
Array.prototype.arrCustom = function() {};

let iterable = [3, 5, 7];
iterable.foo = 'hello';

for (let i in iterable) {
  console.log(i); // logs 0, 1, 2, "foo", "arrCustom", "objCustom"
}

for (let i in iterable) {
  if (iterable.hasOwnProperty(i)) {
    console.log(i); // logs 0, 1, 2, "foo"
  }
}

for (let i of iterable) {
  console.log(i); // logs 3, 5, 7
}

```
<!-- 
#### 如何实现一个for...of？
要实现一个for...of 需要了解下它的主要功能有那些？ -->