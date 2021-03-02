import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SizedBox demo'),
      ),
      body: Center(
        child: SizedBox(
          height: 100,
          width: 200,
          child: const Text('this is SizedBox'),
        ),
      ),
    );
  }
}
