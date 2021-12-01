import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Flutter Demo',
      theme : ThemeData(
          primarySwatch: Colors.blue
      ),
      home : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {

    var data = await get("https://randomuser.me/api/?results=10");

    var jsonData = json.decode(data.body)["results"];

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["name"]["first"] + u["name"]["last"],
                       u["email"], u["picture"]["medium"]);

      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(
            title : Text('Users')
        ),
        body : Container(
            child : FutureBuilder(
              future : _getUsers(),
              builder : (BuildContext context, AsyncSnapshot snapshot){

                if(snapshot.data == null){
                  return Container(child : Center(child : Text("Loading...")));
                }else{
                  return ListView.builder(
                   itemCount : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        leading : CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index].picture),
                        ),
                        title : Text(snapshot.data[index].name),
                        subtitle : Text(snapshot.data[index].email),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailPage(snapshot.data[index])));
                          }
                      );
                    },
                  );
                }

              }
            )
        )
    );
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text(user.name)
      ),
    );
  }
}


class User{

  final String name;
  final String email;
  final String picture;

  User(this.name, this.email, this.picture);

}