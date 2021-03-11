### new


1. 新生成一个对象
2. 链接到原型
3. 绑定this
4. 返回新对象

在调用 `new` 的过程中会发生以上四件事情，因此可以自己来实现一个`new`
```javascript

function create () {
  // 创建一个空对象
  const o = {}
  // 获得构造函数
  const Con = [].shift.call(arguments)
  // 链接到原型
  o.__proto__ = Con.prototype
  // 绑定this
  const result = Con.apply(o, arguments)
  // 确保new出来的是个对象
  return typeof result === 'object' ? result : o
}

``