# 对象 #

## 1. 类型 #

对象是JavaScript 的基础。在JavaScript中一共有六种主要类型：

- string
- number
- boolean
- null
- undefined
- object

注意，简单基本类型 (string、boolean、number、null和undefined)本身并不是对象。null 有时会被当作一种对象类型，但是这其实只是语言本身一个bug，即对null执行 `typeof null` 时会返回字符串 `"object"`。实际上，null 本身是基本类型。


> 注：原理是这样的，不同的对象在底层都表示为二进制，在 JavaScript 中二进制前三位都为 0的话会被判断为object类型，null的二进制表示全为0，自然前三位也是0，所以typeof时会返回 “object”。

