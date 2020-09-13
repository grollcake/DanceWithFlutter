import 'dart:async';

import 'package:RxVMS2/model/user.dart';
import 'package:RxVMS2/service/user_service.dart';

class UserManager {
  StreamController<List<User>> _userlist;
  List<User> _totalList = [];
  bool _isFetch = false;

  UserManager() {
    _userlist = StreamController.broadcast();
  }

  Stream<List<User>> get userlist => _userlist.stream;

  void getUser() async {
    if(_isFetch) return;
    _isFetch = true;

    List<User> users = await UserService.fetch();
    _totalList += users;

    _userlist.add(_totalList);
    _isFetch = false;
  }
}