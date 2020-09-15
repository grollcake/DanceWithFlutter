import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxmvs2/model/user.dart';

class UserService {
  static int _page = 0;
  static String _url = 'https://randomuser.me/api/?page={PAGE}&results=10&seed=Era';

  static Future<List<User>> getUsers() async {
    List<User> users = [];
    String fetchUrl = _url.replaceAll('{PAGE}', (++_page).toString());

    http.Response res = await http.get(fetchUrl);
    var jsonData = json.decode(res.body);

    for (var item in jsonData['results']) {
      User user = User.fromJson(item);

      users.add(user);
    }

    return users;
  }
}

main() async {
  var users = await UserService.getUsers();
  users += await UserService.getUsers();

  for(var user in users){
    print(user.toString());
  }
}
