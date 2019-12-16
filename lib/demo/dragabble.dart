import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  bool _lights = false;
  double _left = 0.0;
  double _top = 0.0;
  double _index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              DragBox(Offset(0.0, 0.0), 'Box one', Colors.lime)
            ],
          ),
        ),
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: 100,
            height: 100,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            print(offset);
            setState(() {
              position = offset;
            });
          },
          onDragStarted: () {

          },
          feedback: Container(
            width: 120,
            height: 120,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(widget.label,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 18.0)),
            ),
          ),
        ));
  }
}
