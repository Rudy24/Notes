import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
