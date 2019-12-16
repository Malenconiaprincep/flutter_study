import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/grouplist.dart';
import 'package:flutter_study/components/userInfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List list = List.generate(Random().nextInt(20) + 10, (i) => 'More Item$i');

  void _onReorder(int oldIndex, int newIndex) {
    print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      if (newIndex == list.length) {
        newIndex = list.length - 1;
      }
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  Widget _buildDrawer() {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[UserInfo(), GroupList()],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      child: Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.apps),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
          Text('我的待办')
        ],
      ),
    );
  }

  Widget _buildList() {
    return ReorderableListView(
          children: list
              .map((m) => Container(
                    key: ObjectKey(m),
                    child: Container(
                      height: 50,
                      child: _buildRow(m, m, Icons.people)
                    ),
                  ))
              .toList(), //不要忘记 .toList()
          onReorder: _onReorder,
        );
  }

  Widget _buildRow(String title, String subtitle, IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(title),
                )
              ],
            ),
          ),
          Icon(Icons.more_horiz)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Expanded(
                child: _buildList()
              )
            ],
          ),
        ),
      ),
    );
  }
}
