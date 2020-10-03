import 'package:flutter/foundation.dart';

class ListService with ChangeNotifier {
  int _speed;
  int _listCount;
  List<String> _listItem;

  int get speed => _speed;
  int get listCount => _listCount;
  List<String> get listItem => _listItem;

  ListService() {
    _speed = 0;
    _listCount = 0;
  }

  void addItem() async {
    while(_speed >= 1) {
      await Future.delayed(Duration(milliseconds: (1000 / _speed).round()));
      _listCount = _listItem.length + 1;
      _listItem.add("item : " + _listCount.toString());
      notifyListeners();
    }
  }

  void chageSpeed() {
    _speed = ++_speed % 3;
    notifyListeners();
  }
}