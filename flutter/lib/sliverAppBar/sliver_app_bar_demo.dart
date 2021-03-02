import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false, // 滚动到顶部是否要固定在导航栏
            floating: false,
            snap: false, // 与floating结合用
            expandedHeight: 200.0,
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 50),
                color: index % 2 == 0 ? Colors.white38 : Colors.grey,
                child: Text(
                  'index $index',
                  style: TextStyle(fontSize: 25),
                ),
              );
            }, childCount: 20),
          )
        ],
      ),
    );
  }
}
