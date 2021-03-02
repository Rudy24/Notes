import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatelessWidget {
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: StreamBuilder<int>(
          stream: counter(),
          initialData: 32,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            print(111);
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('没有Stream');
              case ConnectionState.waiting:
                return Text('等待数据...');
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return Text('Stream已关闭');
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }
}
