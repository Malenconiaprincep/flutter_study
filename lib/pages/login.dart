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
    {"title": "输入昵称", "name": "username",},
    {"title": "输入密码", "name": "password", "obscure": true},
    {"title": "确认密码", "name": "confirmPassword", "obscure": true}
  ];
  List logins = [
    {"title": "输入昵称", "name": "username"},
    {"title": "输入密码", "name": "password", "obscure": true},
  ];

  void resetFormState() {
    _formData = {};
    _formKey.currentState.reset();
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
        onTap: ((v) {
          print(v);
          setState(() {
            _toggleButton = v == 0 ? 'login' : 'reg';
          });
          resetFormState();
        }),
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

  Widget _buildList(List list) {
    return Column(
        children: list.map((item) {
      return Container(
        child: TextFormField(
          obscureText: item["obscure"] == null ? false : true,
            decoration: InputDecoration(
                hintText: item["title"], hintStyle: TextStyle(fontSize: 14.0)),
            onSaved: (v) {
              print(v);
              _formData[item["name"]] = v;
            }),
      );
    }).toList());
  }

  Widget _buildForm(child) {
    return Form(key: _formKey, child: child);
  }

  Widget _buildSubmit() {
    print(_toggleButton);
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
                    child: _buildForm(Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: tabs.map((e) {
                            //创建3个Tab页
                            return Container(
                              alignment: Alignment.center,
                              child: _buildList(e == '登录' ? logins : regs),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: _buildSubmit(),
                      )
                    ],
                  ),
                )))
              ],
            )));
  }
}
