import 'package:flutter/material.dart';

class AnimatedCrossFadeDemo extends StatefulWidget {
  @override
  _AnimatedCrossFadeDemoState createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  bool _show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade demo'),
      ),
      body: Center(
        child: AnimatedCrossFade(
          crossFadeState:
              _show ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
          firstChild: Text('this is first'),
          secondChild: Text('this is seconds'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bluetooth),
        onPressed: () {
          setState(() {
            _show = _show ? false : true;
          });
        },
      ),
    );
  }
}
