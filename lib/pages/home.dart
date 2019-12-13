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
          children: <Widget>[
            UserInfo(),
            GroupList()
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Align(
                child: RaisedButton(
                  child: Text('Launch screen2'),
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    print('vv');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
