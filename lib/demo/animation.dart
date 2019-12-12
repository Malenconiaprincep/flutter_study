import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _duration = Duration(milliseconds: 400);

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, 
                width: animation.value, 
                child: child
            );
          },
          child: child
      ),
    );
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}

class AnimateImage extends AnimatedWidget {
  AnimateImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("imgs/avatar.png",
          width: animation.value, height: animation.value),
    );
  }
}

class AnimatedContainerDemo extends StatefulWidget {
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Color color;
  double borderRadius;
  double margin;

  @override
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(animation);
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: GrowTransition( child: Image.asset('images/pic1.jpg'),animation: animation,));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedContainerDemo(),
    );
  }
}

Future<void> main() async {
  runApp(MyApp());
}
