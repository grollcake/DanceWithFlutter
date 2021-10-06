import 'package:flutter/cupertino.dart';

class CountController extends ChangeNotifier {
  CountController({Key? key}) {
    print('CountController is created');
  }

  int _count = 0;

  int get count => _count;

  void add() {
    _count++;
    notifyListeners();
  }

  void remove() {
    _count--;
    notifyListeners();
  }
}
