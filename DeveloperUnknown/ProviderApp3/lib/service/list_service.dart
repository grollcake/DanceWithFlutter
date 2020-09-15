import 'package:flutter/foundation.dart';

class ListService with ChangeNotifier {
  int _listCount;
  int _speed;
  List<String> _listItem = [];

  ListService() {
    _listCount = 0;
    _speed = 0;
  }

  int get listCount => _listCount;
  int get speed => _speed;
  List<String> get listItem => _listItem;

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
    if(_speed == 1) addItem();
    notifyListeners();
  }
}