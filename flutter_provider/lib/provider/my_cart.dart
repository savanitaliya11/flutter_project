import 'package:flutter/cupertino.dart';

class MyCart with ChangeNotifier {
  List<String> _listitems = ['Food', 'Fruits', 'snackes'];

  List<String> get listitems => _listitems;

  set listitems(List<String> value) {
    _listitems = value;
    notifyListeners();
  }

  dynamic addItems(String newValue) {
    listitems.add(newValue);
    notifyListeners();
  }

  dynamic removeItems(int index) {
    listitems.removeAt(index);
    notifyListeners();
  }
}
