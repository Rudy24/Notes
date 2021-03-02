import 'package:flutter/material.dart';

class AnimatedOpacityDemo extends StatefulWidget {
  @override
  _AnimatedOpacityDemoState createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  double _currentOpacity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedOpacity demo'),
      ),
      body: Center(
        child: AnimatedOpacity(
          child: Container(
            color: Colors.red,
            width: 200,
            height: 200,
          ),
          duration: const Duration(seconds: 1),
          opacity: _currentOpacity,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () {
          setState(() {
            _currentOpacity = _currentOpacity == 1 ? 0 : 1;
          });
        },
      ),
    );
  }
}
