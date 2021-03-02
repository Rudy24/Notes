import 'package:flutter/material.dart';

class AnimatedPaddingDemo extends StatefulWidget {
  @override
  _AnimatedPaddingDemoState createState() => _AnimatedPaddingDemoState();
}

class _AnimatedPaddingDemoState extends State<AnimatedPaddingDemo> {
  double _padValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPadding demo'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.all(_padValue),
            curve: Curves.easeIn,
            child: GestureDetector(
              child: Container(
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  _padValue = _padValue == 0 ? 100 : 0;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
