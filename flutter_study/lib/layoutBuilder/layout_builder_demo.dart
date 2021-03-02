import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutBuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LayoutBuilder'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = MediaQuery.of(context).size;
          if (constraints.maxWidth > 300) {
            return Text('max width 300 ${size.width}, ${size.height}');
          } else {
            return Text('min width 300');
          }
        },
      ),
    );
  }
}
