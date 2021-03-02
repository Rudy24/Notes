import 'package:flutter/material.dart';

class FractionallySizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FractionallySizedBox demo'),
      ),
      body: Center(
        child: Container(
          height: 200,
          color: Colors.red,
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.5,
            child: Container(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}
