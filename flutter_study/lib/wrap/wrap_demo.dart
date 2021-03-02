import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapDemo extends StatelessWidget {
  final List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrap demo'),
      ),
      body: Center(
        child: Wrap(
          // direction: Axis.vertical,
          runSpacing: 16.0,
          spacing: 16.0,
          // alignment: WrapAlignment.spaceBetween,
          children: _list.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Container(width: 40.0, height: 40.0, color: Colors.redAccent),
            );
          }).toList(),
        ),
      ),
    );
  }
}
