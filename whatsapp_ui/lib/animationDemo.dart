import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = ColorTween(begin: Colors.amber, end: Color(0xFFF50057))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));

    _animationController.addListener(() {
      setState(() {
        // print(_animationController.status);
      });
    });

    super.initState();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              if (_animationController.status == AnimationStatus.completed) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            },
            child: Icon(Icons.add),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Container(
              child: Lottie.asset("assets/covid-19.json"),
            ),
          ),
        ],
      ),
    );
  }
}
