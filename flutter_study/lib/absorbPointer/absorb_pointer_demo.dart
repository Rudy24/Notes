import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbsorbPointerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsorbPointer demo'),
      ),
      body: AbsorbPointer(
        absorbing: false,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('1111');
              },
              child: Container(
                height: 50,
                color: Colors.red,
                child: Text('1111'),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('1111');
              },
              child: Container(
                height: 50,
                color: Colors.red,
                child: Text('2222'),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('1111');
              },
              child: Container(
                height: 50,
                color: Colors.red,
                child: Text('333'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
