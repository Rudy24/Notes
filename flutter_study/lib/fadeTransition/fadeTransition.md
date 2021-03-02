# 每周学习一个 Flutter widget 6: FadeTransition --- widget 淡入淡出动画

> flutter widget demo 地址：[github](https://github.com/Rudy24/flutter_study/blob/master/flutter_study_demo1/lib/fadeTransition/fadeTransition.md)

如果你有改变 UI 的状态且还不需要使用到`Flutter`动画时，`Flutter`为你提供了`FadeTransition`小组件，`FadeTransition`可以让你轻松实现淡入淡出的效果。


构造函数

```javascript
FadeTransition({
    Key key,
    @required this.opacity,
    this.alwaysIncludeSemantics = false,
    Widget child,
  })
```

- `opacity`: Animation 控制`child`的透明度
- `child`: Widget 组件

```dart
FadeTransition(
  opacity: animation, // 控制动画
  child: this.child // 淡入淡出的child
)
```

animation

- `parent`: AnimationController 动画过度时间
- `curve`: Curve 动画过度效果


```dart

class FadeTransitionDemo extends StatefulWidget {
  @override
  FadeTransitionDemoState createState() => FadeTransitionDemoState();
}

class FadeTransitionDemoState extends State<FadeTransitionDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 控制器
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    // 动画效果
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    // 监听器
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FadeTransition demo'),
      ),
      body: Center(
        child: FadeTransition(
            opacity: _animation,
            child: FlutterLogo(
              size: 100,
            )),
      ),
    );
  }
}

```

![](fadeTransition.gif)
