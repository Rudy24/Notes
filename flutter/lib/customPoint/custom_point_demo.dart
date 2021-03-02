import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomPointDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('customPoint demo'),
      ),
      body: Center(
        child: CustomPaint(
          painter: Sky(),
          child: Center(
            child: Text(
              'Once upon a time',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: const Alignment(0.7, -0.6),
      radius: 0.2,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  // @override
  // SemanticsBuilderCallback get semanticsBuilder {
  //   return (Size size) {
  //     var rect = Offset.zero & size;
  //     var width = size.shortestSide * 0.4;
  //     rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
  //     return [
  //       CustomPainterSemantics(
  //         rect: rect,
  //         properties: SemanticsProperties(
  //           label: 'Sun',
  //           textDirection: TextDirection.ltr,
  //         ),
  //       ),
  //     ];
  //   };
  // }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
