import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositionedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positioned demo'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                left: 30,
                child: FlutterLogo(
                  size: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
