import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  StreamController _streamController;
  Stream _stream;
  ScrollController _scrollController = ScrollController();

  List<User> users = List();

  void initState() { 
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
    _fatch();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fatch();
      }
    });
  }

  _fatch() async {
    print('fetch');
    Response res = await get("https://randomuser.me/api/?results=20");

    var userArr = json.decode(res.body)["results"];

    print(userArr.length);
    for(var i = 0; i < userArr.length; i++) {
      User user = User(
        name: userArr[i]['name']['first'] + " " + userArr[i]['name']['last'],
        email: userArr[i]['email'],
        image: userArr[i]['picture']['medium'],
      );
      users.add(user);
    }

    _streamController.add(users);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null) {
            return Center(child: Text("loading"),);
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListBody(
                children: [
                  ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].image),),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String image;

  User({this.name, this.email, this.image});
}