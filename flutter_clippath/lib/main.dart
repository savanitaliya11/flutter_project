import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Center(
          //   child: ClipPath(
          //     clipper: MyCustomClippath(),
          //     child: Container(
          //       height: 200,
          //       width: 200,
          //       decoration: BoxDecoration(
          //         color: Colors.pink,
          //       ),
          //     ),
          //   ),
          // ),
          // Center(
          //   child: ClipPath(
          //     clipper: MyCustomClip(),
          //     child: Container(
          //       height: 200,
          //       width: 200,
          //       decoration: BoxDecoration(
          //         color: Colors.pink.withOpacity(0.5),
          //       ),
          //     ),
          //   ),
          // ),
          Center(
            child: ClipPath(
              clipper: ArcToPoint(),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArcToPoint extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 40;
    Path path = Path();

    path.moveTo(radius, 0); // p1
    path.lineTo(size.width - radius, 0); // p2
    path.arcToPoint(Offset(size.width, radius)); // p3
    path.lineTo(size.width, size.height - radius); // p4
    path.arcToPoint(Offset(size.width - radius, size.height),
        radius: Radius.circular(radius)); // p5
    path.lineTo(radius, size.height); // p6
    path.arcToPoint(Offset(0, size.height - radius),
        radius: Radius.circular(radius), clockwise: false); // p7
    path.lineTo(0, radius); // p8
    path.arcToPoint(Offset(radius, 0), radius: Radius.elliptical(40, 40));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyCustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height - 50);
    path.cubicTo(size.width / 4, size.height, size.width - 50,
        size.height - 100, size.width, size.height - 50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyCustomClippath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height - 50);
    path.cubicTo(size.width / 4, size.height - 100, size.width - 50,
        size.height, size.width, size.height - 50);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
