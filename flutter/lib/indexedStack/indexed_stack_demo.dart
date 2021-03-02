import 'dart:math';

import 'package:flutter/material.dart';

class IndexedStackDemo extends StatefulWidget {
  @override
  _IndexedStackDemoState createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<IndexedStackDemo> {
  int _widgetIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("IndexedStack demo"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    var rng = new Random();
                    _widgetIndex = _widgetIndex = rng.nextInt(3);
                  });
                },
                child:
                    Container(width: 50, height: 50, color: Colors.deepOrange),
              ),
              Row(
                children: <Widget>[
                  IndexedStack(
                    index: _widgetIndex,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                        child: Text('0'),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.greenAccent,
                        child: Text('1'),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blueAccent,
                        child: Text('2'),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
