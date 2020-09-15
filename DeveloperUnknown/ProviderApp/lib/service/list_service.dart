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
      await Future.delayed(Duration(milliseconds: (1000 / _speed).round()));
      _listCount = _listItems.length + 1;
      _listItems.add('Item $_listCount');
      print('List generated : ' + _listItems[_listCount - 1]);
      notifyListeners();
    }
  }

  void changeSpeed() {
    _speed = ++_speed % 3;
    if(_speed == 1) generateList();
    //_speed가 0이였을 경우 1
    //_speed가 1이였을 경우 2
    //_speed가 2였을   경우 3 % 3임으로 0
    notifyListeners();
  }
}