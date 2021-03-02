# 每周学习一个 Flutter widget 6: FutureBuilder --- 异步 UI 更新

> flutter widget demo 地址：[github](https://github.com/Rudy24/flutter_study/blob/master/flutter_study_demo1/lib/futureBuilder/futureBuilder.md)

很多时候我们会依赖一些异步数据来动态更新 UI，比如在打开一个页面时我们需要先从互联网上获取数据，在获取数据的过程中我们显示一个加载框，等获取到数据时我们再渲染页面；`Flutter`提供了个 `FutureBuilder`widget 去快速实现效果。

```javascript

FutureBuilder({
  this.future,
  this.initialData,
  @required this.builder,
})

```

- `future`: `FutureBuilder`依赖的`Future`，通常是一个异步耗时任务
- `initialData`: 初始化默认数据
- `builder`: Widget 构建器；该构建器会在`Future`执行的不同阶段被多次调用, ，构建器签名如下：
  `Function (BuildContext context, AsyncSnapshot snapshot)`
  snapshot 会包含当前异步任务的状态信息及结果信息 ，比如我们可以通过 snapshot.connectionState 获取异步任务的状态信息、
  通过 snapshot.hasError 判断异步任务是否有错误等等，完整的定义读者可以查看 AsyncSnapshot 类定义。

```javascript

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder demo'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _future,
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start. ');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return defaultLoadingIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Container(
                  height: 300,
                  width: 300,
                  child: Image.network(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578842509583&di=25c774f1659acc32c297455124dd3f14&imgtype=0&src=http%3A%2F%2Fi1.sinaimg.cn%2Fent%2Fd%2F2008-06-04%2FU105P28T3D2048907F326DT20080604225106.jpg'),
                );
            }

            return null;
          },
        ),
      ),
    );
  }

```

![](futureBuilder.gif)
