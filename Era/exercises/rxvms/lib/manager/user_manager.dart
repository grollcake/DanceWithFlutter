import 'dart:async';
import 'package:rxvms/model/user.dart';
import 'package:rxvms/service/user_service.dart';

class UserManager {
  List<User> _totalUsers = [];
  int lastCount = 0;
  bool _isFetching = false;
  StreamController<List<User>> _userList;
  // StreamController<int> _userCounter;

  UserManager() {
    _userList = StreamController.broadcast();
    // _userCounter = StreamController<int>();
    // this._userList.stream.listen((List<User> data) => _userCounter.add(data.length));
  }

  // Stream<int> get userCounter => _userCounter.stream;
  Stream<List<User>> get userList => _userList.stream;
  bool get isFetching => _isFetching;

  void getUsers() async {
    if (_isFetching) return;
    _isFetching = true;

    List<User> users = await UserService.fetchUsers();
    _totalUsers += users;

    for (int i = lastCount; i < _totalUsers.length; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      _userList.add(_totalUsers.sublist(0, i + 1));
    }
    lastCount = _totalUsers.length;

    _isFetching = false;
  }
}
