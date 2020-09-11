import 'dart:async';
import 'package:rxvms/model/user.dart';
import 'package:rxvms/service/user_service.dart';

class UserManager {
  StreamController<int> _userCounter;

  UserManager() {
    _userCounter = StreamController<int>();

    this.getUserList.listen((List<User> data) => _userCounter.add(data.length));
  }

  Stream<int> get userCounter => _userCounter.stream;

  Stream<List<User>> get getUserList async* {
    List<User> users = await UserService.fetchUsers();
    for (int i = 0; i < users.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield users.sublist(0, i + 1);
    }
  }
}
