import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CustomScrollView Demo'),
        ),
        body: Column(
          children: <Widget>[
            // ListViewDemo(),
            Expanded(
              child: CustomScrollViewDemo2(),
            )
          ],
        ));
  }
}

class CustomScrollViewDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: ScrollPhysics.,
      // shrinkWrap: false,
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: index % 2 == 1 ? Colors.blueAccent : Colors.greenAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Text('index $index'),
              ),
            );
          }, childCount: 20),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        )
      ],
    );
  }
}

class ListViewDemo extends StatelessWidget {
  final List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: _list
                  .map((f) => Container(
                        color: f % 2 == 1 ? Colors.amberAccent : Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('index $f'),
                      ))
                  .toList(),
            ),
          ),
          Container(
            height: 400,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 1 ? Colors.blue : Colors.grey,
                  child: Text('index $index'),
                );
              },
              itemCount: 20,
              itemExtent: 30,
            ),
          )
        ],
      ),
    );
  }
}
