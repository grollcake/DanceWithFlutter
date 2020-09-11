import 'dart:convert';

import 'package:future_and_stream/model/user.dart';
import 'package:http/http.dart';
import 'dart:async';

class UserService{

  static int _page = 0;
  static final String _url = "https://randomuser.me/api/?page={PAGE}&results=10&seed=newmiracle";

  static Future<List<User>>getUsers() async {
    final String fetchUrl = _url.replaceAll('{PAGE}', (++_page).toString());
    print(fetchUrl);

    Response res = await get(fetchUrl);

    var jsonArr = json.decode(res.body)["results"];

    List<User> users = [];
    for(var j in jsonArr) {
      users.add(User(name : j['name']['first'] + '' + j['name']['last'],
      email : j['email'],
      picture : j['picture']['medium']));
    }
    return users;
  }
}

void main() async {

  List<User> users = await UserService.getUsers();
  users = users + await UserService.getUsers();
  for(var item in users){
    print(item.toString());

  }


}