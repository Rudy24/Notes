import 'package:flutter/material.dart';

class RichTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RichText demo'),
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
              text: 'Hello ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: 'bold',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' world'),
              ]),
        ),
      ),
    );
  }
}
