import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimatedBuilderDemo extends StatefulWidget {
  @override
  AnimatedBuilderDemoState createState() => AnimatedBuilderDemoState();
}

class AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
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
        title: const Text('AnimatedBuilder demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: Container(
            height: 200.0,
            width: 200.0,
            color: Colors.green,
            child: const Center(
              child: Text('Wee'),
            ),
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * Math.pi,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
