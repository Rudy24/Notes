import 'package:flutter/material.dart';

class ColorFilteredDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColorFiltered Demo'),
      ),
      body: Center(
        child: Container(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.screen),
            child: Image.network(
                'http://img2.mtime.cn/up/1686/1125686/CC160A79-1F22-432F-9D9F-39F2ACF2ED66_500.jpg'),
          ),
        ),
      ),
    );
  }
}
