import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_rxvms/model/users.dart';

class UserService{

  static int _page = 0;
  static String _url = 'https://randomuser.me/api/?page={PAGE}&results=10&seed=newmiracle';

  static Future<List<User>> getUsers() async{

    List<User> users = [];

    String fetchUrl = _url.replaceAll('{PAGE}',(++_page).toString());

    http.Response res = await http.get(_url);
    var jsonData = json.decode(res.body);

      int i = 0;
      for(var item in jsonData['results']){
        User user = User.fromJson(item);
        // User user = User(name : "${item['name']['first']} ${item['name']['last']}", email : "${item['email']}" , picture : "${item['picture']['meditum']}");
        i++;
        //print(user.toString());
        users.add(user);
      }

      return users;
  }
}

void main() async{

  var users = await UserService.getUsers();
  users += await UserService.getUsers();

  for(var user in users){
    print(user.toString());
  }

}