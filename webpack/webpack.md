#### 概念

`webpack`是一个用于现代 JavaScript 应用程序的静态模块打包工具。

loader：
webpack 只能理解 JavaScript 和 JSON 文件，这时 webpack 开箱可用的自带能力。
loader 让 webpack 能够去处理其他类型的文件，并将它们转换为有效的模块，
以供应用程序使用，以及被添加到依赖中来。

loader 有两个属性：

1. `test` 属性，识别出哪些文件会被转换。
2. `use` 属性，定义出在转换时，应该使用哪个 loader。

```javascript
const path = require("path");
module.exports = {
  output: {
    filename: "my-first-webpack.bundle.js",
  },
  module: {
    rules: [
      {
        test: /\.txt$/,
        use: "raw-loader",
      },
    ],
  },
};
```

plugin:
loader 用于转换某些类型的模块，而插件则可以用于执行范围更广的任务。
包括：打包优化，资源管理，注入环境变量。
