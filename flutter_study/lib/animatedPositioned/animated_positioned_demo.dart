import 'package:flutter/material.dart';

class AnimatedPositionedDemo extends StatefulWidget {
  @override
  _AnimatedPositionedDemoState createState() => _AnimatedPositionedDemoState();
}

class _AnimatedPositionedDemoState extends State<AnimatedPositionedDemo> {
  double _width = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPositioned demo'),
      ),
      body: Center(
        child: Stack(children: <Widget>[
          AnimatedPositioned(
              width: _width,
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _width = 100.0;
                  });
                },
                child: Container(
                  width: _width,
                  height: 100.0,
                  color: Colors.red,
                ),
              ))
        ]),
      ),
    );
  }
}
