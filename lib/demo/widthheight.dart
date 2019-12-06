import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print('width is $width; height is $height');
    return Scaffold(
      appBar: AppBar(
        title: Text('Width & Height'),
      ),
      body: Center(
        child: Container(
          color: Colors.redAccent,
          width: width / 2,
          height: height / 2,
        ),
      ),
    );
  }
}