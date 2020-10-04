import 'package:RemindApp/model/user.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserService {
  static final String _url = 'https://randomuser.me/api/?results=10';
  static Future<List<User>> getUsers() async{
    List<User> users= [];
    Response res = await get(_url);
    var jsonData = json.decode(res.body)["results"];
    
    for (var item in jsonData) {
      User user = User.fromJson(item);
      users.add(user);
    }
    return users;
  }
}

main() async {
  var users = await UserService.getUsers();
  for(var user in users) {
    print(user.toString());
  }
  //terminal : dart lib/service/user_service.dart 실행
}