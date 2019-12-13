import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipOval(
              child: Image.asset(
                "images/pic1.jpg",
                width: 50,
              ),
            ),
          ),
          Text(
            "makuta",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
