import 'package:RxVMS3/model/user.dart';
import 'package:RxVMS3/service/user_service.dart';
import 'dart:async';

class UserManager {
  List<User> _totaluser = [];
  StreamController<List<User>> _userlist;
  bool _isFetch = false;

  UserManager() {
    _userlist = StreamController.broadcast();
  }

  Stream<List<User>> get userlist => _userlist.stream;

  void getUser() async {
    if (_isFetch) return;
    _isFetch = true;
    print("fetch");
    List<User> users = await UserSerive.fetch();
    _totaluser += users;
    _userlist.add(_totaluser);
    _isFetch = false;
  }
}
