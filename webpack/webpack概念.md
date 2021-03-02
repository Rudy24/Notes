### webpack 学习
核心概念
+ 入口(entry)
+ 输出(output)
+ loader
+ 插件(plugins)

### 入口(entry)

入口起点(entry point)指示 webpack 应该使用哪个模块，来作为构建其内部依赖图的开始，webpack 会找出有哪些模块和 library 是入口起点（直接和间接）依赖的。

默认值是 ./src/index.js，然而，可以通过在 webpack 配置中配置 entry 属性，来指定一个不同的入口起点（或者也可以指定多个入口起点）。

webpack.config.js

```javascript

  module.exports = {
      entry: './path/to/my/entry/file.js'
    }

```


### 出口(output)

output 属性告诉 webpack 在哪里输出它所创建的 bundles，以及如何命名这些文件，主输出文件默认为 ./dist/main.js，其他生成文件的默认输出目录是 ./dist。

你可以通过在配置中指定一个 output 字段，来配置这些处理过程：
webpack.config.js

```javascript
  const path = require('path');

  module.exports = {
    entry: './path/to/my/entry/file.js',
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: 'my-first-webpack.bundle.js'
    }
  };

```


在上面的示例中，我们通过 output.filename 和 output.path 属性，来告诉 webpack bundle 的名称，以及我们想要 bundle 生成(emit)到哪里。可能你想要了解在代码最上面导入的 path 模块是什么，它是一个 Node.js 核心模块，用于操作文件路径。


### loader

作为开箱即用的自带特性，webpack 自身只支持 JavaScript。而 loader 能够让 webpack 处理那些非 JavaScript 文件，并且先将它们转换为有效 模块，然后添加到依赖图中，这样就可以提供给应用程序使用。

在更高层面，在 webpack 的配置中 loader 有两个特征：

1. test 属性，用于标识出应该被对应的 loader 进行转换的某个或某些文件。
2. use 属性，表示进行转换时，应该使用哪个 loader。

```javascript
  const path = require('path');

  module.exports = {
    output: {
      filename: 'my-first-webpack.bundle.js'
    },
    module: {
      rules: [
        { test: /\.txt$/, use: 'raw-loader' }
      ]
    }
  };

```

以上配置中，对一个单独的 module 对象定义了 rules 属性，里面包含两个必须属性：test 和 use。这告诉 webpack 编译器(compiler) 如下信息：

> “嘿，webpack 编译器，当你碰到「在 require()/import 语句中被解析为 '.txt' 的路径」时，在你对它打包之前，先使用 raw-loader 转换一下。”

> 重要的是要记得，在 webpack 配置中定义 loader 时，要定义在 module.rules 中，而不是 rules。为了使你受益于此，如果没有按照正确方式去做，webpack 会给出警告。

### 插件(plugins)

loader 被用于转换某些类型的模块，而插件则可以用于执行范围更广的任务，插件的范围包括：打包优化、资源管理和注入环境变量。

webpack.config.js

```javascript

  const HtmlWebpackPlugin = require('html-webpack-plugin'); // 通过 npm 安装
  const webpack = require('webpack'); // 用于访问内置插件

  module.exports = {
    module: {
      rules: [
        { test: /\.txt$/, use: 'raw-loader' }
      ]
    },
    plugins: [
      new HtmlWebpackPlugin({template: './src/index.html'})
    ]
  };

```

在上面的示例中，html-webpack-plugin 会为你的应用程序生成一个 html 文件，然后自动注入所有生成的 bundle。

### 模式

通过将 mode 参数设置为 development, production 或 none，可以启用对应环境下 webpack 内置的优化。默认值为 production。

```javascript

  module.exports = {
    mode: 'production'
  };
```

### 浏览器兼容性 

webpack 支持所有 ES5 兼容（IE8 及以下不提供支持）的浏览器。webpack 的 import() 和 require.ensure() 需要环境中有 Promise。如果你想要支持旧版本浏览器，你应该在使用这些 webpack 提供的表达式之前，先 加载一个 polyfill。
