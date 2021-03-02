import 'package:flutter/material.dart';

class AspectRatioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AspectRatio demo'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcToniS1UNmqwm-M0XYkdzNjnp1dU3_CDmtYRBhDmf4yOA3iIMrE'),
          ),
        ),
      ),
    );
  }
}
