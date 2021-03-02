import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerDemo extends StatefulWidget {
  @override
  AnimatedContainerDemoState createState() => AnimatedContainerDemoState();
}

class AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer demo'),
      ),
      body: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        child: Center(
          child: AnimatedContainer(
              width: _selected ? 100.0 : 150.0,
              height: _selected ? 100.0 : 200.0,
              decoration: BoxDecoration(
                  color: _selected ? Colors.redAccent : Colors.greenAccent,
                  borderRadius: _selected
                      ? BorderRadius.circular(50)
                      : BorderRadius.circular(0)),
              alignment:
                  _selected ? Alignment.center : AlignmentDirectional.topCenter,
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn),
        ),
      ),
    );
  }
}
