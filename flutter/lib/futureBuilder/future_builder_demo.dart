import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderDemo extends StatefulWidget {
  @override
  _FutureBuilderDemoState createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future =
        http.get('https://api.apiopen.top/getJoke?page=1&count=2&type=video');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder demo'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _future,
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start. ');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return defaultLoadingIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Container(
                  height: 300,
                  width: 300,
                  child: Image.network(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578842509583&di=25c774f1659acc32c297455124dd3f14&imgtype=0&src=http%3A%2F%2Fi1.sinaimg.cn%2Fent%2Fd%2F2008-06-04%2FU105P28T3D2048907F326DT20080604225106.jpg'),
                );
            }

            return null;
          },
        ),
      ),
    );
  }
}

Widget activityIndicator({double radius = 10.0, Color color}) {
  return UnconstrainedBox(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(radius: radius)
          : SizedBox(
              width: radius * 2,
              height: radius * 2,
              child: CircularProgressIndicator(
                backgroundColor: color,
                strokeWidth: 3,
              ),
            ));
}

Widget defaultLoadingIndicator([double size = 10]) {
  return Center(
      child: activityIndicator(color: Color(0xFF85C6C5), radius: size));
}
