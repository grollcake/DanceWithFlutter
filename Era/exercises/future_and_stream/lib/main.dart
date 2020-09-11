import 'package:flutter/material.dart';
import 'package:future_and_stream/manager/user_manager.dart';

import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxVMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'RxVMS 알아보기'),
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
  int _counter = 0;
  UserManger _userManger = UserManger();

  @override
  void initState() {
    _userManger.getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Chip(
            label: StreamBuilder<int>(
              stream: _userManger.userCount,
              builder: (context, snapshot) {
                int count = snapshot.data ?? 0;
                return Text('$count');
              }
            ),
          )
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: _userManger.userSteam,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              User user = snapshot.data[index];
              return ListTile(
                title: Text(user.name),
              );
            },
          );
        },
      ),
    );
  }
}
