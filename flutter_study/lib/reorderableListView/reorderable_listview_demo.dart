import 'package:flutter/material.dart';

class ReorderableListViewDemo extends StatefulWidget {
  @override
  _ReorderableListViewDemoState createState() =>
      _ReorderableListViewDemoState();
}

class _ReorderableListViewDemoState extends State<ReorderableListViewDemo> {
  final List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReorderableListView Demo'),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;

              final int _item = _list.removeAt(oldIndex);
              _list.insert(newIndex, _item);
            }
          });
        },
        header: Container(
          alignment: Alignment(-0.9, 0),
          height: 45,
          padding: EdgeInsets.only(top: 15),
          child: Text('例子'),
        ),
        children: _list
            .map((item) => Container(
                  key: ValueKey(item.toString()),
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.greenAccent,
                  child: Text(item.toString()),
                ))
            .toList(),
      ),
    );
  }
}
