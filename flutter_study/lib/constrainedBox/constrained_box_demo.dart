import 'package:flutter/material.dart';

class ContrainedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContrainedBox demo'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 300, minHeight: 50.0),
          child: Container(
            height: 5,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
