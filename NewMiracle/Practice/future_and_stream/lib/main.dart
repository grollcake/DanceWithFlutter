import 'package:flutter/material.dart';

import 'manage/user_manager.dart';
import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  UserManager _userManager = UserManager();

  @override
  void initState() {
    // TODO: implement initState
    _userManager.getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Chip(
              label : StreamBuilder<int>(
                stream: _userManager.userCount,
                builder: (context, snapshot) {
                  int count = snapshot.data ?? 0;
                  return Text('$count');
                }
              ),
            )
          ],
        ),
        body: Center(
          child: StreamBuilder<List<User>>(
            stream: _userManager.userStream,
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index){
                    User user = snapshot.data[index];
                    return ListTile(
                       title : Text(user.name),
                       leading: CircleAvatar(backgroundImage: NetworkImage(user.picture),),
                       subtitle: Text(user.email),
                     );

                  });
            }
          ),
        ));
  }
}
