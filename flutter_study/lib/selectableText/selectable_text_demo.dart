import 'package:flutter/material.dart';

class SelectableTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectableText demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SelectableText(
              'my selectable text',
              showCursor: true,
              cursorColor: Colors.green,
              cursorRadius: Radius.circular(5),
            ),
            SizedBox(
              height: 100,
            ),
            Text('my selectable text2')
          ],
        ),
      ),
    );
  }
}
