import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: _buildDrawer(),
      body: Align(
        alignment: Alignment.bottomRight,
        child: RaisedButton(
          child: Text('Launch screen1'),
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
