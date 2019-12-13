import 'package:flutter/material.dart';

class Loading {
  static dynamic ctx;
  static void before(text) {
    // 请求前显示弹窗
    showDialog(
      // 传入 context
      context: ctx,
      // 构建 Dialog 的视图
      builder: (ctx) {
        return Index(text: text);
      }
    );
  }

  static void complete() {
    // 完成后关闭loading窗口
    print('>>> complete');
    // Navigator.of(ctx, rootNavigator: true).pop();
  }
}

// 弹窗内容
class Index extends StatelessWidget {
  final String text;

  Index({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.none)),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
