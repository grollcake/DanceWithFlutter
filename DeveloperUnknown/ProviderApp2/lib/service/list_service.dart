import 'package:flutter/foundation.dart';

class ListService with ChangeNotifier {
  int _listCount = 0;
  List<String> _listItem = [];
  int _speed;

  int get listCount => _listCount;
  List<String> get listItem => _listItem;
  int get speed => _speed;

  ListService() {
    _speed = 0;
  }

  void listAddAction() async {
    while(_speed >= 1) {
      _listCount = _listItem.length + 1;
      await Future.delayed(Duration(milliseconds: (1000 / _speed).round()));
      _listItem.add("Item "+_listCount.toString());
      notifyListeners();
    }
  }

  void chageSpeed() {
    _speed = ++_speed % 3;
    if(_speed == 1) listAddAction();
    notifyListeners();
  }
}