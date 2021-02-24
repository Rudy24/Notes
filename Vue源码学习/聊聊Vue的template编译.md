### 聊聊Vue的template编译

1. Vue的template编辑 讲了什么？
通过编译器 compile 中的 baseCompile 将template解析成一个AST，再通过optimize 做一些优化(主要是做一些静态标记，以便在patch时，跳过对静态标记的处理，从而减少过程的比较，优化了patch的性能)，最后通过generate 得到 render 和 staticRenderFns。
2. Vue的template编辑 怎么实现的？

createCompiler
- compile(baseCompile) 将 template 转换成AST，render函数以及staticRenderFns函数
- compileToFunctions 是带缓存的编译器，同时staticRenderFns以及render函数会被转成Function对象

```javascript

function baseCompile (template, options) {
  // parse 解析得到AST
  const ast = parse(tempate.trim(), options)
  optimize(ast, options)
  // 根据AST生成所需的code(内部包含render与staticRenderFns)
  const code = generate(ast, options)
  return {
    ast,
    render: code.render,
    staticRender: code.staticRenderFns
  }
}


```

3. Vue的template编辑 得到了什么？
最终render函数回返回一个VNode节点，在_update的时候，经过patch与之前的VNode节点进行比较，得出差异后将差异渲染到真实的DOM上。
