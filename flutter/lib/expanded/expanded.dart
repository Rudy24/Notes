import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expended demo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'start',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerStart(),
            const Text(
              'end',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerEnd(),
            const Text(
              'center',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerCenter(),
            const Text(
              'spaceAround',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerSpaceAround(),
            const Text(
              'spaceBetween',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerSpaceBetween(),
            const Text(
              'spaceEvenly',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerSpaceEvenly(),
            const Text(
              '中间自适应',
              style: TextStyle(fontSize: 25),
            ),
            _buildContainerExpanded()
          ],
        ),
      ),
    );
  }

  Container _buildContainerStart() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowStart(),
    );
  }

  Container _buildContainerEnd() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowEnd(),
    );
  }

  Container _buildContainerCenter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowCenter(),
    );
  }

  Container _buildContainerSpaceAround() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowSpaceAround(),
    );
  }

  Container _buildContainerSpaceBetween() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowSpaceBetween(),
    );
  }

  Container _buildContainerSpaceEvenly() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowSpaceEvenly(),
    );
  }

  Container _buildContainerExpanded() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      child: _buildRowExpanded(),
    );
  }

  Row _buildRowStart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowEnd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowCenter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowSpaceAround() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowSpaceBetween() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowSpaceEvenly() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Container(
          color: Colors.amber,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Row _buildRowExpanded() {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          height: 50,
          width: 50,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.amber,
            width: 50,
            height: 50,
          ),
        ),
        Container(
          color: Colors.blue,
          height: 50,
          width: 50,
        )
      ],
    );
  }
}
