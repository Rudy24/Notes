### Object.assign

`Object.assign` 方法用于将所有**可枚举属性**的值从一个或多个源对象分配到目标对象，它将返回目标对象。

> Object.assign(target, ...sources)

- target: 目标对象
- sources: 源对象
- 返回值：target(目标对象)

```javascript
if (typeof Object.assign !== "function") {
  Object.defineProperty(Object, "assign", {
    value: function assign(target, varArgs) {
      "use strict";
      if (target === null)
        throw new TypeError("Cannot convert undefined or null to object");
      let to = Object[target];

      for (let index = 1; index < arguments.length; index++) {
        let nextSource = arguments[index];
        if (nextSource !== null) {
          for (let nextKey in nextSource) {
            if (nextSource.hasOwnProperty(nextKey)) {
              to[nextKey] = nextSource[nextKey];
            }
          }
        }
      }
      return to;
    },
    writable: true,
    configurable: true,
  });
}
```
