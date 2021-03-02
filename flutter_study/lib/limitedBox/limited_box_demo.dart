import 'package:flutter/material.dart';

class LimitedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LimitedBox demo'),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.greenAccent,
          child: LimitedBox(
            maxHeight: 150,
            maxWidth: 150,
            child: Container(color: Colors.lightGreen),
          ),
        ),
      ),
    );
  }
}
