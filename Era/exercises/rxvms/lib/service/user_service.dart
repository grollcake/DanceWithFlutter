import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxvms/model/user.dart';

class UserService {
  static String _url = 'https://randomuser.me/api/?page=1&results=10&seed=Era';

  static Future<List<User>> fetchUsers() async {
    http.Response res  = await http.get(_url);
    List results = json.decode(res.body)['results'];
    List<User> users = results.map((result) => User.fromJson(result)).toList();
    return users;
  }
}

void main() async {
  List<User> users = await UserService.fetchUsers();
  for(var u in users) print(u.toString());
}