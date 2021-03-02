import 'package:flutter/material.dart';

class ClipRRectDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClippRRect demo'),
      ),
      body: Center(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      child: Image.network('http://img2.mtime.cn/up/1686/1125686/CC160A79-1F22-432F-9D9F-39F2ACF2ED66_500.jpg',fit: BoxFit.cover,),
                      height: 200,
                      width: 200,
                    )
                  ),
                  ClipOval(
                    child: SizedBox(
                      child: Image.network('http://img2.mtime.cn/up/1686/1125686/CC160A79-1F22-432F-9D9F-39F2ACF2ED66_500.jpg',fit: BoxFit.cover,),
                      height: 200,
                      width: 200,
                    )
                  ),
                ],
              ),
            )
    );
  }
}