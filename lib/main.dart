import 'package:flutter/material.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flutter layout demo'),
            ),
            body: Center(child: FavoriteWidget())));
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

enum SingingCharacter { man, woman }

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool isAgree = false;
  bool _isFavorited = true;
  bool isSwitch = false;
  int _favoriteCount = 41;
  String _name = '';
  String _password = '';
  final _formData = {};
  List formList;
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;
  initState() {
    super.initState();
    formList = [
      {"title": '输入框', "type": "input"},
      {"title": 'checkbox', "type": "checkbox"},
      {"title": 'switch', "type": "switch"},
    ];
  }

  Widget buildGrid() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in formList) {
      tiles.add(new Row(children: <Widget>[new Text(item['title'])]));
    }
    content = new Column(
        children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
        //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
        );
    return content;
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  void _toggleCheck(value) {
    setState(() {
      isAgree = value;
    });
  }

  void _switchChange(value) {
    setState(() {
      isSwitch = value;
    });
  }

  Widget buildInput() {
    return TextFormField(validator: (value) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }, onChanged: (String v) {
      print(v);
    }, onFieldSubmitted: (String v) {
      print(v);
    }, onSaved: (String v) {
      _name = v;
    });
  }

  Widget buildCheckBox() {
    return Checkbox(
      value: true,
      onChanged: _toggleCheck,
    );
  }

  Widget buildSwitch() {
    return Switch(
      value: isSwitch,
      onChanged: _switchChange,
      activeColor: Color.fromRGBO(255, 0, 0, 1),
    );
  }

  final _formKey = GlobalKey<FormState>();
  SingingCharacter _character = SingingCharacter.man;
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // new TextFormField(
          //   decoration: new InputDecoration(
          //     labelText: '用户名',
          //   ),
          //   onSaved: (val) {
          //     _name = val;
          //   },
          // ),
          // new TextFormField(
          //   decoration: new InputDecoration(
          //     labelText: 'Password',
          //   ),
          //   obscureText: true,
          //   validator: (val) {
          //     return val.length < 4 ? "密码长度错误" : null;
          //   },
          //   onSaved: (val) {
          //     _password = val;
          //   },
          // ),
          Center(
            child: Row(
              children: <Widget>[
                Text('性别：'),
                Expanded(
                  child: ListTile(
                    title: const Text('男'),
                    leading: Radio(
                      value: SingingCharacter.man,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: ListTile(
                  title: const Text('女'),
                  leading: Radio(
                    value: SingingCharacter.woman,
                    groupValue: _character,
                    onChanged: (SingingCharacter value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ))
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "请输入用户名",
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none //隐藏下划线              
            ),
            onSaved: (String v) {
              print(v);
              _formData['username'] = v;
            },
          ),
          TextFormField(
            focusNode: focusNode2, //关联focusNode1
            keyboardType: TextInputType.emailAddress,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                var _form = _formKey.currentState;

                if (_form.validate()) {
                  _form.save();
                  print(_name);
                  print(_password);
                  print(_character);
                }
              },
              child: Text('Submit'),
            ),
          ),
          RaisedButton(
            child: Text("隐藏键盘"),
            onPressed: () {
              // 当所有编辑框都失去焦点时键盘就会收起
              focusNode1.unfocus();
              focusNode2.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
