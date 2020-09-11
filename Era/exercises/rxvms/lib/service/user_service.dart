import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxvms/model/user.dart';

class UserService {
  static int page = 0;
  static String _url = 'https://randomuser.me/api/?page={PAGE}&results=10&seed=Era';

  static Future<List<User>> fetchUsers() async {
    String url = _url.replaceAll('{PAGE}', (++page).toString());
    print('fetching from $url');
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