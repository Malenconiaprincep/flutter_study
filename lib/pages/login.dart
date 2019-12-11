import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _toggleButton = 'login';

  void _handleButton(v) {
    setState(() {
      _toggleButton = v;
    });
  }

  Widget _buildHeaderBar() {
    final TextStyle _biggerFont =
        TextStyle(fontSize: 18.0, color: Color.fromRGBO(217, 217, 217, 1));
    final TextStyle _active = TextStyle(color: Color.fromRGBO(33, 33, 33, 1));

    return Container(
        margin: new EdgeInsets.symmetric(vertical: 20.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _handleButton('login');
                  },
                  child: Container(
                      child: Text(
                    '登录',
                    style: _toggleButton == 'login'
                        ? _biggerFont.merge(_active)
                        : _biggerFont,
                  )),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _handleButton('reg');
                  },
                  child: Container(
                      child: Text(
                    '注册',
                    style: _toggleButton == 'reg'
                        ? _biggerFont.merge(_active)
                        : _biggerFont,
                  )),
                )
              ],
            ),
          ),
          Text('暂不登录')
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: new EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[_buildHeaderBar()],
              ),
              RaisedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
