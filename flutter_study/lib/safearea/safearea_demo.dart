import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeAreaDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: List.generate(
              100,
              (i) => Container(
                    color: i % 2 == 1 ? Colors.red : Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: const Text(
                      'This is some text',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  )),
        ),
      ),
    );
  }
}
