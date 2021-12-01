import 'package:flutter/foundation.dart';

class ListService with ChangeNotifier{

  int _speed = 0;
  int _listCount = 0;
  List<String> _listItems = [];

  int get speed => _speed;
  int get listCount => _listCount;
  List<String> get listItems => _listItems;

  ListService(){
    _speed = 0;
  }

  void generateList() async {

    while(_speed >= 1){
      await Future.delayed(Duration(milliseconds: 1000 ~/ _speed));
      _listCount = _listItems.length + 1;
      _listItems.add('Item $_listCount');
      notifyListeners();
    }
  }

  void changeSpeed(){
    _speed = ++_speed % 3;
    if(_speed == 1) generateList();
    notifyListeners();
  }
}