import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Color color = Colors.red;
  double height = 50;
  double width = 50;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 50.0,
        upperBound: 100.0,
        duration: Duration(milliseconds: 800));

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            return Container(
              color: color,
              height: _animationController.value,
              width: _animationController.value,
            );
          },
          animation: _animationController,
          child: Container(
            width: width,
            height: height,
            color: color,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            {
              if (_animationController.status == AnimationStatus.completed) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
