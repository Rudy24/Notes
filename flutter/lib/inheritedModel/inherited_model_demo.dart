import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataContainerDemo extends StatefulWidget {
  @override
  DataContainerDemoState createState() => DataContainerDemoState();
}

class DataContainerDemoState extends State<DataContainerDemo> {
  int num1 = 0;
  int num2 = 0;

  void incNum1() {
    setState(() {
      this.num1++;
    });
  }

  void incNum2() {
    setState(() {
      this.num2++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Inherited(
        num1: num1,
        num2: num2,
        parent: this,
        child: const InheritedModelDemo());
  }
}

class InheritedModelDemo extends StatelessWidget {
  const InheritedModelDemo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedModel demo'),
      ),
      body: Row(
        children: <Widget>[Counter1(), Counter2()],
      ),
    );
  }
}

class Inherited extends InheritedModel<String> {
  final int num1;
  final int num2;

  final DataContainerDemoState parent;

  static Inherited of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<Inherited>(context, aspect: aspect);
  }

  Inherited(
      {Key key, @required Widget child, this.num1, this.num2, this.parent})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(Inherited oldWidget) {
    return num1 != oldWidget.num1 || num2 != oldWidget.num2;
  }

  @override
  bool updateShouldNotifyDependent(
      Inherited oldWidget, Set<String> dependencies) {
    var updateA = num1 != oldWidget.num1 && dependencies.contains('num1');
    var updateB = num1 != oldWidget.num2 && dependencies.contains('num2');
    return updateA || updateB;
  }
}

class Counter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Inherited c = Inherited.of(context, 'num1');
    return RaisedButton(
      child: Text('${c.num1}'),
      onPressed: c.parent.incNum1,
    );
  }
}

class Counter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Inherited c = Inherited.of(context, 'num2');
    return RaisedButton(
      child: Text('$c.num2'),
      onPressed: c.parent.incNum2,
    );
  }
}
