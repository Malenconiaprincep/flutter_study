import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _toggleButton = 'login';
  var _formData = {};

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

  Widget _buildLogin() {
    return Column(
      children: <Widget>[Text('登录')],
    );
  }

  Widget _buildReg() {
    return Column(
      children: <Widget>[
        TextFormField(
            decoration: const InputDecoration(hintText: '用户名'),
            onSaved: (v) {
              _formData['username'] = v;
            }),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(hintText: '密码'),
          onSaved: (v) {
            _formData['password'] = v;
          },
        )
      ],
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _toggleButton == 'login' ? _buildLogin() : _buildReg()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: new EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[_buildHeaderBar(), _buildForm()],
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          bottom: 30,
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                              _formKey.currentState.save();
                              print(_formData);
                            }
                          },
                          child: Text(_toggleButton == 'login' ? '登录' : '注册'),
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
