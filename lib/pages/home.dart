import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Home'),
          // 自定义Drawer图标
          // leading: new IconButton(
          //     icon: new Icon(Icons.apps),
          //     onPressed: () => _scaffoldKey.currentState.openDrawer())),
      ),
      drawer: _buildDrawer(),
      body: Align(
        alignment: Alignment.bottomRight,
        child: RaisedButton(
          child: Text('Launch screen2'),
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            print('vv');
          },
        ),
      ),
    );
  }
}
