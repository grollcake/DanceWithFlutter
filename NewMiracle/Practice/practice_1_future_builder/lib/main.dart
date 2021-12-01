import 'package:flutter/material.dart';

 
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Future<List<User>> _getUsers() async{
  //
  //   var data = await get("https://randomuser.me/api/?results=10");
  //
  //   var jsonData = json.decode(data.body)["results"];
  //
  //   List<User> users = [];
  //
  //   for(var u in jsonData){
  //
  //     User user = User(u["name"]["first"]+u["name"]["last"],
  //         u["email"], u["picture"]);
  //
  //     users.add(user);
  //   }
  //
  //   return users;
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
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