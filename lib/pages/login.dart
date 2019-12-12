import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String _toggleButton = 'login';
  var _formData = {};
  TabController _tabController; //需要定义一个Controller
  List tabs = ["登录", "注册"];
  List regs = [
    {"title": "输入昵称", "name": "username"},
    {"title": "输入密码", "name": "password"},
    {"title": "确认密码", "name": "confirmPassword"}
  ];

  void _handleButton(v) {
    setState(() {
      _toggleButton = v;
    });
  }

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget _buildTabar() {
    final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
    return TabBar(
        labelStyle: _biggerFont,
        labelColor: Color.fromRGBO(33, 33, 33, 1),
        unselectedLabelColor: Color.fromRGBO(217, 217, 217, 1),
        labelPadding: new EdgeInsets.all(1.0),
        indicatorColor: Color.fromRGBO(0, 0, 0, 0),
        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList());
  }

  Widget _buildHeaderBar() {
    final TextStyle _biggerFont =
        TextStyle(fontSize: 18.0, color: Color.fromRGBO(217, 217, 217, 1));
    final TextStyle _active = TextStyle(color: Color.fromRGBO(33, 33, 33, 1));

    return Container(
        margin: new EdgeInsets.symmetric(vertical: 20.0),
        child: Row(children: <Widget>[
          SizedBox(width: 200, child: _buildTabar()),
          Expanded(
              child: Align(
            alignment: Alignment.topRight,
            child: Container(child: Text('暂不登录')),
          ))
        ]));
  }

  Widget _buildLogin() {
    return Column(
      children: <Widget>[Text('登录')],
    );
  }

  Widget _buildReg() {
    return Column(
        children: regs.map((reg) {
      return Container(
        child: TextFormField(
            decoration: InputDecoration(
                hintText: reg["title"], hintStyle: TextStyle(fontSize: 14.0)),
            onSaved: (v) {
              print(v);
              _formData[reg["name"]] = v;
            }),
      );
    }).toList()

        // children: <Widget>[
        //   TextFormField(
        //       decoration: const InputDecoration(hintText: '输入昵称', hintStyle: TextStyle( fontSize: 14.0)),
        //       onSaved: (v) {
        //         _formData['username'] = v;
        //       }),
        //   TextFormField(
        //     obscureText: true,
        //     decoration: const InputDecoration(hintText: '设置密码', hintStyle: TextStyle(fontSize: 14.0)),
        //     onSaved: (v) {
        //       _formData['password'] = v;
        //     },
        //   ),
        //   TextFormField(
        //     obscureText: true,
        //     decoration: const InputDecoration(hintText: '确认密码', hintStyle: TextStyle(fontSize: 14.0)),
        //     onSaved: (v) {
        //       _formData['confirm_password'] = v;
        //     },
        //   )
        // ],
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

  Widget _buildSubmit() {
    return Stack(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: new EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                _buildHeaderBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: tabs.map((e) {
                      //创建3个Tab页
                      return Container(
                        alignment: Alignment.center,
                        child: e == '登录' ? _buildLogin() : _buildReg(),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: _buildSubmit(),
                )
              ],
            )));
  }
}
