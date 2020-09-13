import 'package:RxVMS/model/user.dart';
import 'package:RxVMS/service/user_service.dart';
import 'dart:async';

class UserManager {
  List<User> _totalList = [];
  int lastCount = 0;
  bool _isFetch = false;
  StreamController<List<User>> _userList;

  UserManager() {
    _userList = StreamController.broadcast();
  }

  Stream<List<User>> get userList => _userList.stream;

  void getUsers() async {
    if(_isFetch) return;
    _isFetch = true;

    List<User> users = await UserService.fetch();
    _totalList += users;
    _userList.add(_totalList);

    lastCount = _totalList.length;

    _isFetch = false;
  }
}