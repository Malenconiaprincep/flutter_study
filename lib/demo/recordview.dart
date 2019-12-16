import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = List.generate(Random().nextInt(20) + 10, (i) => 'More Item$i');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('listview reorded'),
      ),
      body: Center(
        child: ReorderableListView(
          children: list
              .map((m) => Container(
                    key: ObjectKey(m),
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[Icon(Icons.mood_bad), Text(m)],
                      ),
                    ),
                  ))
              .toList(), //不要忘记 .toList()
          onReorder: _onReorder,
        ),
      ),
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      if (newIndex == list.length) {
        newIndex = list.length - 1;
      }
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }
}
