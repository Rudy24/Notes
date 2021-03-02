import 'package:flutter/material.dart';

class SliderDemo extends StatefulWidget {
  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _rating = 12.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider demo'),
      ),
      body: Center(
        child: Slider(
          value: _rating,
          onChanged: (newRating) {
            setState(() {
              _rating = newRating;
            });
          },
          min: 0,
          max: 100,
          divisions: 10,
          label: '$_rating',
        ),
      ),
    );
  }
}
