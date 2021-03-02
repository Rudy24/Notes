import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpacityDemo extends StatefulWidget {
  @override
  OpacityDemoState createState() => OpacityDemoState();
}

class OpacityDemoState extends State<OpacityDemo> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opacity demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('asdfasdfasd'),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              child: Icon(Icons.access_alarms),
            ),
            Container(
              child: Opacity(
                opacity: _visible ? 1.0 : 0.2,
                child: Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578842509583&di=25c774f1659acc32c297455124dd3f14&imgtype=0&src=http%3A%2F%2Fi1.sinaimg.cn%2Fent%2Fd%2F2008-06-04%2FU105P28T3D2048907F326DT20080604225106.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            const Text('this is opacity')
          ],
        ),
      ),
    );
  }
}
