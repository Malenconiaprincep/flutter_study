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

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool isAgree = false;
  bool _isFavorited = true;
  bool isSwitch = false;
  int _favoriteCount = 41;
  String _name = '';
  List formList;
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
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (String v) {
        print(v);
      },
      onFieldSubmitted: (String v) {
        print(v);
      },
      onSaved: (String v) {
        _name = v;
      }
    );
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

  @override
  Widget build(BuildContext context) {
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    for (var item in formList) {
      var formComponent;
      print(item['type']);
      if (item['type'] == 'input') {
        formComponent = buildInput;
      }
      if (item['type'] == 'checkbox') {
        formComponent = buildCheckBox;
      }
      if (item['type'] == 'switch') {
        formComponent = buildSwitch; 
      }
      //  formComponent = buildInput;
      tiles.add(new Row(children: <Widget>[
        new Text(item['title']),
        new Expanded(
          child: formComponent(),
        ),
        buildSwitch()
      ]));
    }
    content = new Column(
        children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
        //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
        );
    
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Expanded(child: content),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState.validate()) {
                // Process data.
                print(_formKey.currentState);
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],),
    );
  }
}
