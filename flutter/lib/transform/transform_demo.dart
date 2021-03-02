import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransfromDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfrom Demo'),
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          child: new Transform(
            alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
            transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepOrange,
              child: const Text('Apartment for rent!'),
            ),
          ),
        ),
      ),
    );
  }
}
