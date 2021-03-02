import 'package:flutter/material.dart';

class ToggleButtonsDemo extends StatefulWidget {
  @override
  _ToggleButtonsDemoState createState() => _ToggleButtonsDemoState();
}

class _ToggleButtonsDemoState extends State<ToggleButtonsDemo> {
  List<bool> _selections = List.generate(4, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToggleButtons demos'),
      ),
      body: Center(
        child: ToggleButtons(
          isSelected: _selections,
          color: Colors.greenAccent,
          selectedBorderColor: Colors.orange,
          fillColor: Colors.red,
          children: <Widget>[
            Icon(Icons.local_cafe),
            Icon(Icons.fast_forward),
            Icon(Icons.cake),
            Icon(Icons.leak_remove),
          ],
          onPressed: (int index) {
            setState(() {
              _selections[index] = !_selections[index];
            });
          },
        ),
      ),
    );
  }
}
