import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableDemo extends StatelessWidget {
  final List<int> _list = [
    1,
    2,
    3,
    4,
    5,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table demo'),
      ),
      body: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle, // 对其方式
        // defaultColumnWidth: FixedColumnWidth(30.0),
        defaultColumnWidth: IntrinsicColumnWidth(), // 设置默认column宽度
        columnWidths: {
          0: FractionColumnWidth(0.1),
          1: FractionColumnWidth(0.2),
          2: FractionColumnWidth(0.3),
          3: FractionColumnWidth(0.4),
        }, // 可以控制具体列得占比
        border: TableBorder.all(),
        children: _list
            .map(
              (n) => TableRow(children: [
                Container(
                  color: Colors.amber,
                  width: 30,
                  height: 130,
                ),
                Container(
                  color: Colors.blue,
                  width: 60,
                  height: 40,
                ),
                Container(
                  color: Colors.redAccent,
                  width: 60,
                  height: 90,
                ),
                Container(
                  color: Colors.amberAccent,
                  width: 60,
                  height: 60,
                ),
              ]),
            )
            .toList(),
      ),
    );
  }
}
