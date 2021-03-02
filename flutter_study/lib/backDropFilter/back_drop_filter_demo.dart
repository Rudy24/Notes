import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackDropFilterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BackDropFilter demo'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Text('0' * 10000),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 200.0,
                    child: Text('Hello World'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
