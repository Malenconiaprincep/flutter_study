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
          body: DraggableGridViewDemo()),//此处为本例将要展示的页面
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

typedef bool CanAccept(int oldIndex, int newIndex);

typedef Widget DataWidgetBuilder<T>(BuildContext context, T data);

class SortableGridView<T> extends StatefulWidget {
  final DataWidgetBuilder<T>
      itemBuilder; //用于生成GridView的Item Widget的函数，接收一个context参数和一个数据源参数，返回一个Widget
  final CanAccept canAccept; //是否接受拖拽过来的数据的回调函数
  final List<T> dataList; //数据源List
  final Axis scrollDirection; //GridView的滚动方向
  final int
      crossAxisCount; //非主轴方向的item数量，即 如果GridView的滚动方向是垂直方向，那么这个字段的意思就是有多少列；如果为水平方向，则此字段代表有多少行。
  final double
      childAspectRatio; //每个Item的宽高比，由于GridView的Item默认是正方形的，可以通过这个比例稍作调整。可能会有我不知道的别的办法。

  SortableGridView(
    this.dataList, {
    Key key,
    this.scrollDirection = Axis.vertical,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.0,
    @required this.itemBuilder,
    @required this.canAccept,
  })  : assert(itemBuilder != null),
        assert(canAccept != null),
        assert(dataList != null && dataList.length >= 0),
        super(key: key);
  @override
  State<StatefulWidget> createState() => _SortableGridViewState<T>();
}

class _SortableGridViewState<T> extends State<SortableGridView> {
  List<T> _dataList; //数据源
  List<T> _dataListBackup; //数据源备份，在拖动时 会直接在数据源上修改 来影响UI变化，当拖动取消等情况，需要通过备份还原
  bool _showItemWhenCovered = false; //手指覆盖的地方，即item被拖动时 底部的那个widget是否可见；
  int _willAcceptIndex = -1; //当拖动覆盖到某个item上的时候，记录这个item的坐标
//  int _draggingItemIndex = -1; //当前被拖动的item坐标
//  ScrollController _scrollController;//当item数量超出屏幕 拖动Item到底部或顶部 可使用ScrollController滚动GridView 实现自动滚动的效果。

  @override
  void initState() {
    super.initState();
    _dataList = widget.dataList;
    _dataListBackup = _dataList.sublist(0);
//    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
//      controller: _scrollController,
      childAspectRatio: widget.childAspectRatio, //item宽高比
      scrollDirection: widget.scrollDirection, //默认vertical
      crossAxisCount: widget.crossAxisCount, //列数
      children: _buildGridChildren(context),
    );
  }

  //生成widget列表
  List<Widget> _buildGridChildren(BuildContext context) {
    final List list = List<Widget>();
    for (int x = 0; x < _dataList.length; x++) {
      list.add(_buildDraggable(context, x));
    }
    return list;
  }

  //绘制一个可拖拽的控件。
  Widget _buildDraggable(BuildContext context, int index) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return LongPressDraggable(
          data: index,
          child: DragTarget<int>(
            //松手时 如果onWillAccept返回true 那么久会调用，本案例不使用。
            onAccept: (int data) {},
            //绘制widget
            builder: (context, data, rejects) {
              print('$index index $_willAcceptIndex willIndex');
              return _willAcceptIndex >= 0 && _willAcceptIndex == index
                  ? null
                  : widget.itemBuilder(context, _dataList[index]);
            },
            //手指拖着一个widget从另一个widget头上滑走时会调用
            onLeave: (int data) {
              //TODO 这里应该还可以优化，当用户滑出而又没有滑入某个item的时候 可以重新排列  让当前被拖走的item的空白被填满
              print('$data is Leaving item $index');
              _willAcceptIndex = -1;
              setState(() {
                _showItemWhenCovered = false;
                _dataList = _dataListBackup.sublist(0);
              });
            },
            //接下来松手 是否需要将数据给这个widget？  因为需要在拖动时改变UI，所以在这里直接修改数据源
            onWillAccept: (int fromIndex) {
              print('$index will accept item $fromIndex');
              final accept = fromIndex != index;
              if (accept) {
                _willAcceptIndex = index;
                print(_willAcceptIndex);
                _showItemWhenCovered = true;
                _dataList = _dataListBackup.sublist(0);
                final fromData = _dataList[fromIndex];
                setState(() {
                  _dataList.removeAt(fromIndex);
                  _dataList.insert(index, fromData);
                });
              }
              return accept;
            },
          ),
          onDragStarted: () {
            //开始拖动，备份数据源
//            _draggingItemIndex = index;
            _dataListBackup = _dataList.sublist(0);
            print('item $index ---------------------------onDragStarted');
          },
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            print(
                'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
            //拖动取消，还原数据源

            setState(() {
              _willAcceptIndex = -1;
              _showItemWhenCovered = false;
              _dataList = _dataListBackup.sublist(0);
            });
          },
          onDragCompleted: () {
            //拖动完成，刷新状态，重置willAcceptIndex
            print("item $index ---------------------------onDragCompleted");
            setState(() {
              _showItemWhenCovered = false;
              _willAcceptIndex = -1;
            });
          },
          //用户拖动item时，那个给用户看起来被拖动的widget，（就是会跟着用户走的那个widget）
          feedback: SizedBox(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: widget.itemBuilder(context, _dataList[index]),
          ),
          //这个是当item被拖动时，item原来位置用来占位的widget，（用户把item拖走后原来的地方该显示啥？就是这个）
          childWhenDragging: Container(
            child: SizedBox(
              child: _showItemWhenCovered
                  ? widget.itemBuilder(context, _dataList[index])
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class DraggableGridViewDemo extends StatelessWidget {
  final List<String> channelItems = List<String>();

  @override
  Widget build(BuildContext context) {
    for (int x = 0; x < 20; x++) {
      channelItems.add("x = $x");
    }
    return SortableGridView(
      channelItems,
      childAspectRatio: 3.0, //宽高3比1
      crossAxisCount: 1, //3列
      scrollDirection: Axis.vertical, //竖向滑动
      canAccept: (oldIndex, newIndex) {
        return true;
      },
      itemBuilder: (context, data) {
        return Card(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Center(
            child: Text(data),
          ),
        ));
      },
    );
  }
}