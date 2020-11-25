import 'package:flutter/cupertino.dart';

class Data with ChangeNotifier {
  String data = "Hello";
  void changeData(String a) {
    data = a;
    notifyListeners();
  }
}
