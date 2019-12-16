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
//          body: MyDraggable()),
//          body: Drag2TargetPage()),
//          body: DraggableItemDemo()),
          body: GridViewPage3()),//此处为本例将要展示的页面
    );
  }
}

class GridViewPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GridViewPage3State();
  final List _dataList = <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ].toList();
}

class _GridViewPage3State extends State<GridViewPage3> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3.0, //item宽高比
      scrollDirection: Axis.vertical, //默认vertical
      crossAxisCount: 1, //列数
      children: _buildGridChildren(context),
    );
  }

  //生成widget列表
  List<Widget> _buildGridChildren(BuildContext context) {
    final List list = List<Widget>();
    for (int x = 0; x < widget._dataList.length; x++) {
      list.add(_buildItemWidget(context, x));
    }
    return list;
  }

  Widget _buildItemWidget(BuildContext context, int index) {
    return LongPressDraggable(
      data: index, //这里data使用list的索引，方便交换数据
      child: DragTarget<int>(
        //松手时 如果onWillAccept返回true 那么久会调用
        onAccept: (data) {
          setState(() {
            final temp = widget._dataList[data];
            widget._dataList.remove(temp);
            widget._dataList.insert(index, temp);
          });
        },
        //绘制widget
        builder: (context, data, rejects) {
          return Card(
            child: Center(
              child: Text('x = ${widget._dataList[index]}'),
            ),
          );
        },
        //手指拖着一个widget从另一个widget头上滑走时会调用
        onLeave: (data) {
          print('$data is Leaving item $index');
        },
        //接下来松手 是否需要将数据给这个widget？  因为需要在拖动时改变UI，所以在这里直接修改数据源
        onWillAccept: (data) {
          print('$index will accept item $data');
          return true;
        },
      ),
      onDragStarted: () {
        //开始拖动，备份数据源
        print('item $index ---------------------------onDragStarted');
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        print(
            'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
        //拖动取消，还原数据源
      },
      onDragCompleted: () {
        //拖动完成，刷新状态，重置willAcceptIndex
        print("item $index ---------------------------onDragCompleted");
      },
      //用户拖动item时，那个给用户看起来被拖动的widget，（就是会跟着用户走的那个widget）
      feedback: SizedBox(
        child: Center(
          child: Icon(Icons.feedback),
        ),
      ),
      //这个是当item被拖动时，item原来位置用来占位的widget，（用户把item拖走后原来的地方该显示啥？就是这个）
      childWhenDragging: Container(
        child: Center(
          child: Icon(Icons.child_care),
        ),
      ),
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
            print('>>');
            print(widget);
            print('<<<');
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
        width: 10.0,
        height: 10.0,
        child: Icon(Icons.feedback),
      ),
    );
  }
}