import 'package:flutter/material.dart';

class DataTableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable demo'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text('name')),
            DataColumn(label: Text('year'), numeric: true)
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Dash'), showEditIcon: true),
              DataCell(Text('2018')),
            ]),
            DataRow(cells: [
              DataCell(Text('rudy')),
              DataCell(Text('11111111111')),
            ]),
          ],
        ),
      ),
    );
  }
}
