import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilderDemo extends StatefulWidget {
  @override
  ValueListenableBuilderDemoState createState() =>
      ValueListenableBuilderDemoState();
}

class ValueListenableBuilderDemoState
    extends State<ValueListenableBuilderDemo> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('Good Job');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ValueListenableBuilder demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              ValueListenableBuilder(
                valueListenable: _counter,
                child: goodJob,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('$value'),
                      child,
                    ],
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: () => _counter.value += 1,
        ));
  }
}
