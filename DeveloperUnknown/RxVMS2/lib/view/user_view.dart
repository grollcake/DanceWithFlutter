import 'package:flutter/material.dart';
import 'package:RxVMS2/manager/user_manager.dart';

class MyHome extends StatefulWidget {
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  UserManager userManager;
  ScrollController _scrollController;

  void initState() {
    super.initState();
    userManager = UserManager()..getUser();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        userManager.getUser();
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RxVMS App"),
        leading: IconButton(
          icon: Icon(Icons.cloud_download),
          onPressed: userManager.getUser,
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Chip(
              label: StreamBuilder(
                stream: userManager.userlist,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  String count = (snapshot.data?.length ?? 0).toString();
                  return Text(count, style: TextStyle(color: Colors.white),);
                },
              ),
            ),
          )
        ],
      ),
      body: UserPage(),
    );
  }

  Widget UserPage() {
    return StreamBuilder(
      stream: userManager.userlist,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.data == null) {
          return Center(child: CircularProgressIndicator(),);
        } else {
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

        }
      },
    );
  }
}