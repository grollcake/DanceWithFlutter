import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:RxVMS2/model/user.dart';

class UserService {
  static final _url = "https://randomuser.me/api/?results=10";
  static Future<List<User>> fetch() async {
    Response res = await get(_url);
    List userArr = json.decode(res.body)["results"];
    List<User> userList = userArr.map((result) => User.fromJson(result)).toList();
    return userList;
  }
}