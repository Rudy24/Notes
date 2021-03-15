### flat

`flat()`方法会按照一个可指定的深度递归遍历数组，并将所有元素与遍历到的子数组中的元素合并为一个新数组返回。

> var newArray = arr.flat([depth])

- depth: 指定要提取嵌套数组的结构深度，默认值为 1。
- 返回值：一个包含将数组与子数组中所有元素的新数组。


```javascript
var arr1 = [1, 2, [3, 4]];
arr1.flat();
// [1, 2, 3, 4]

var arr2 = [1, 2, [3, 4, [5, 6]]];
arr2.flat();
// [1, 2, 3, 4, [5, 6]]

var arr3 = [1, 2, [3, 4, [5, 6]]];
arr3.flat(2);
// [1, 2, 3, 4, 5, 6]

//使用 Infinity，可展开任意深度的嵌套数组
var arr4 = [1, 2, [3, 4, [5, 6, [7, 8, [9, 10]]]]];
arr4.flat(Infinity);
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

```

来实现个polyfill吧，这里有两种实现方式：
```javascript

// 第一种 扁平化，利用concat
function flattened (arr, idx = 1) {
  if (typeof idx !== 'number' || idx <= 0) return arr.slice()
  const flaFunc = arr => [].concat(...arr)
  // 过滤第一层
  const flatArr = flaFunc(arr)
  if (idx === 1) return flatArr
  // 如果第一层还存在数组，做好遍历下一层的准备
  const has = flatArr.some(item => Array.isArray(item))
  --idx
  // 如果没有数组存在了，不管idx是多少，直接返回
  if (!has) return flatArr
  else {
    // 递归下
    return flattened(flatArr, idx)
  }
}
// 第二种 利用reduce
function flattened (arr, idx = 1) {
  return idx > 0 ? arr.reduce((acc, val) => acc.concat(Array.isArray(val) ? flattened(val, idx - 1) : val), []) : arr.slice()
}

```