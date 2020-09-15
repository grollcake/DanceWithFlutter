import 'package:flutter/foundation.dart';

class ListService with ChangeNotifier {
  int _speed;
  int _listCount = 0;
  List<String> _listItems = [];

  int get listCount => _listCount;
  int get speed => _speed;
  List<String> get listItems => _listItems;

  ListService() {
    _speed = 0;
  }

  void generateList() async {
    while(_speed >= 1) {
      await Future.delayed(Duration(milliseconds: 1000 ~/ _speed));
      _listCount = _listItems.length + 1;
      _listItems.add('Item $_listCount');
      print('List generated: ' + _listItems[_listCount-1]);
      notifyListeners();
    }
  }

  void changeSpeed() {
    if (_speed == 0) {
      _speed += 1;
      generateList();
    }
    else if (_speed == 1) {
      _speed += 1;
    }
    else {
      _speed = 0;
    }
    notifyListeners();
  }

}