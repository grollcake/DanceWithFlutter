import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    Future<List<User>> _getUsers() async{

    var data = await get("https://randomuser.me/api/?results=1");
    var jsonData = json.decode(data.body);

    print(jsonData);

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["index"], u["about"], u["name"], u["email"], u["picture"]);
      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child : FutureBuilder(
          future : _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                    child: Text('Loading....'),
                  )
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(snapshot.data[index].name),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index]
                              .picture),
                        ),
                        subtitle: Text(snapshot.data[index].email),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  DetailPage(snapshot.data[index]))
                          );
                        }
                    );
                  }
              );
            }
          }
        )
      )
    );
  }
}

class DetailPage extends StatelessWidget{

    final User user;

    DetailPage(this.user);

    @override
    Widget build(BuildContext context){
      return Scaffold(
          appBar : AppBar(
            title : Text(user.name),
          )
      );
    }
}

class User{

  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);

}

