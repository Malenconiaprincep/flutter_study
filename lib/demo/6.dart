// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget buildOne() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: const Icon(Icons.account_circle, size: 65),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Flutter McFlutter',
              style: TextStyle(fontSize: 32),
            ),
            Text('Experienced App Developer', style: TextStyle(fontSize: 20))
          ],
        )
      ],
    );
  }

  Widget buildTwo() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('123 Main Street', style: TextStyle(fontSize: 20)),
          Text('(415) 555-0198', style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }

  Widget menuBar() {
    final double size = 40.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(Icons.accessibility, size: size),
        Icon(Icons.alarm_on, size: size),
        Icon(Icons.phone, size: size)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Flutter'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[buildOne(), buildTwo(), menuBar()],
            ),
          ),
        ));
  }
}
