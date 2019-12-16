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
          body: MyDraggable()),//用于测试Draggable的Widget
    );
  }
}

class MyDraggable extends StatelessWidget {
  final data;
  const MyDraggable({this.data = "MyDraggable", Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: data,
      child: Container(
        width: 150.0,
        height: 150.0,
        color: Colors.red[500],
        child: Center(
          child: Text('Draggable'),
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