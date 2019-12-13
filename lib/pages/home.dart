import 'package:flutter/material.dart';
import 'package:flutter_study/components/grouplist.dart';
import 'package:flutter_study/components/userInfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
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

  Widget _buildList() => ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 如果itemcount 为null 则为无限
      itemCount: 5,
      itemBuilder: /*1*/ (context, i) {
        return _buildRow('makuta1', 'fewew', Icons.people);
      });

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
                child: _buildList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
