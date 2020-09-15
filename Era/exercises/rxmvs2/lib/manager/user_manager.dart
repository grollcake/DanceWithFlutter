import 'dart:async';
import 'package:rxmvs2/model/user.dart';
import 'package:rxmvs2/service/user_service.dart';

class UserManager {
  StreamController<List<User>> _userStream;

  Stream<List<User>> get userStream => _userStream.stream;
  
  UserManager() {
    _userStream = StreamController<List<User>>.broadcast();
  }
  
  void getUser() async {
    List<User> users = await UserService.getUsers();
    for (int i = 0; i < users.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      _userStream.add(users.sublist(0, i+1));
    }
  }
}

main() {
  UserManager userManager = UserManager();
  userManager.userStream.listen((event) {
    print(event);
  });
  userManager.userStream.listen((event) {
    print(event.length);
  });
  userManager.getUser();
}