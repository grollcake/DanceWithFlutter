import 'dart:async';

import 'package:future_and_stream/model/user.dart';
import 'package:future_and_stream/service/user_service.dart';

class UserManger {
  StreamController<List<User>> _userStream;
  StreamController<int> _userCount;

  Stream<List<User>> get userSteam => _userStream.stream;
  Stream<int> get userCount => _userCount.stream;

  UserManger() {
    _userStream = StreamController<List<User>>();
    _userCount = StreamController<int>();
  }

  void getUserList() async {
    List<User> users = await UserService.getUsers();
    for (int i = 0; i < users.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      _userStream.add(users.sublist(0, i+1));
      _userCount.add(i+1);
    }
  }
}
