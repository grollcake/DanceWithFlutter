import 'dart:async';
import 'dart:convert';
import 'package:RxVMS3/model/user.dart';
import 'package:http/http.dart';

class UserSerive {
  static final _url = "https://randomuser.me/api/?results=10";
  static Future<List<User>> fetch() async {
    Response res = await get(_url);
    List userArr = json.decode(res.body)["results"];
    List<User> users = userArr.map((result) => User.fromJson(result)).toList();
    return users;
  }
}
