import 'dart:async';
import 'dart:convert';
import 'package:RxVMS/model/user.dart';
import 'package:http/http.dart';

class UserService {

  static Future<List<User>> fetch() async {
    String _url = "https://randomuser.me/api/?results=10";
    Response res = await get(_url);
    List result = json.decode(res.body)["results"];

    List<User> users = result.map((result) => User.fromJson(result)).toList();
    return users;
  }
}