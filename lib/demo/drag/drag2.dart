import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

///用于展示Demo的界面，其中的MaterialApp、ThemeData、AppBar都是不必要的，只是稍微美观一点。
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("DraggableDemo"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                MyDraggableTarget(data: '哈哈'),MyDraggableTarget(data: '呵呵')],
            ),
          )), //用于测试Draggable的Widget
    );
  }
}

class MyDraggableTarget<T> extends StatefulWidget {
  final T data;

  MyDraggableTarget({@required this.data, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyDraggableTargetState(text: data);
}

class _MyDraggableTargetState extends State<MyDraggableTarget> {
  var text;

  _MyDraggableTargetState({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: text,
      child: Container(
        width: 150.0,
        height: 150.0,
        color: Colors.red[500],
        child: DragTarget(
          onWillAccept: (data) {
            print("data = $data onWillAccept");
            return data != null;
          },
          onAccept: (data) {
            print("data = $data onAccept");
            setState(() {
              text = data;
            });
          },
          onLeave: (data) {
            print("data = $data onLeave");
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 150.0,
              height: 150.0,
              color: Colors.blue[500],
              child: Center(
                child: Text(text),
              ),
            );
          },
        ),
      ),
      feedback: Container(
        width: 150.0,
        height: 150.0,
        color: Colors.blue[500],
        child: Icon(Icons.feedback),
      ),
    );
  }
}