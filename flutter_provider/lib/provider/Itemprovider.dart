import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  List<String> _items = ["food", "fruit", "mobile"];

  List<String> get item => _items;

  void add(String data) {
    _items.add(data);
    notifyListeners();
  }
}
