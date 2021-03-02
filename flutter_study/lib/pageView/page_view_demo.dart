import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewDemo extends StatefulWidget {
  @override
  PageViewDemoState createState() => PageViewDemoState();
}

class PageViewDemoState extends State<PageViewDemo> {
  PageController _controller;

  PageView _pageViews;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    _pageViews = PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          color: Colors.red,
          child: Text('Colors.red'),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text('Colors.blue'),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.greenAccent,
          child: Text('Colors.greenAccent'),
        )
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView demo'),
      ),
      body: Center(
        child: _pageViews,
      ),
    );
  }
}
