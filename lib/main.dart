import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/login.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => LandingPage(),
      '/home': (context) => Home(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => Login(),
    },
  ));
}

class LandingPage extends StatelessWidget {
  Future<bool>checkIfAuthenticated() async {
    final response = await http.get('http://localhost:3000/login');
    if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    final statusCode = json.decode(response.body)['code'];
    print(statusCode);
    return statusCode == 0 ? true : false;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
  }

  @override
  Widget build(BuildContext context) {
    checkIfAuthenticated().then((success) {
      // if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      // } else {
        // Navigator.pushReplacementNamed(context, '/login');
      // }
    });
    return Scaffold(
      body: Center(child: Text('Loading'),)
    );
  }
}