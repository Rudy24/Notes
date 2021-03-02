import 'package:flutter/material.dart';

class DraggableDemo extends StatefulWidget {
  @override
  _DraggableDemoState createState() => _DraggableDemoState();
}

class _DraggableDemoState extends State<DraggableDemo> {
  Color _draggableColor = Colors.grey;
  Offset _offset = Offset(80, 80);
  Color redColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable demo'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: Draggable(
                data: redColor,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: redColor,
                ),
                feedback: Container(
                  width: 100.0,
                  height: 100.0,
                  color: redColor.withOpacity(1),
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    this._offset = offset;
                  });
                },
              )),
          Center(
            child: DragTarget(onWillAccept: (Color color) {
              return true;
            }, onAccept: (Color color) {
              setState(() {
                _draggableColor = color;
              });
            }, builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200,
                height: 200,
                color: _draggableColor,
              );
            }),
          )
        ],
      ),
    );
  }
}
