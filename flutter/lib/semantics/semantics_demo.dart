import 'package:flutter/material.dart';

class SemanticsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semantics demo'),
      ),
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          width: 200,
          height: 200,
          child: Semantics(
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5QHkdQ6XCLuzfWBNhdwrOTc-31_Am1JcPG1SDhFSFeMErVWg6&s'),
            label: 'An Image of name',
            enabled: true,
            readOnly: true,
          ),
        ),
      ),
    );
  }
}
