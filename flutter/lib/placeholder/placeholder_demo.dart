import 'package:flutter/material.dart';

class PlaceholderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder demo'),
      ),
      body: Center(
        child: Placeholder(
          color: Colors.greenAccent,
          strokeWidth: 1,
          fallbackHeight: 200,
        ),
      ),
    );
  }
}
