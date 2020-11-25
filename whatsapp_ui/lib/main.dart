import 'package:flutter/material.dart';
import 'package:whatsapp_ui/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primaryColor: Colors.black26),
      home: HomePage(),
    );
  }
}
