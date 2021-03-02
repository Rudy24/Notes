import 'package:flutter/material.dart';

class DataContainer extends StatefulWidget {
  @override
  DataContainerState createState() => DataContainerState();
}

class DataContainerState extends State<DataContainer> {
  int num = 0;

  void incNum() {
    setState(() {
      this.num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidget Demo'),
      ),
      body: InheritedContainer(
        num: num,
        parent: this,
        child: Counter(),
      ),
    );
  }
}

class InheritedContainer extends InheritedWidget {
  final int num;
  final DataContainerState parent;

  static InheritedContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedContainer);
  }

  InheritedContainer({
    Key key,
    @required Widget child,
    @required this.parent,
    @required this.num,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedContainer oldWidget) {
    return num != oldWidget.num;
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InheritedContainer c = InheritedContainer.of(context);
    return RaisedButton(
      child: Text('${c.num}'),
      onPressed: c.parent.incNum,
    );
  }
}
