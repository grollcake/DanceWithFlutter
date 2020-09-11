import 'package:flutter/material.dart';
import 'package:rxvms/manager/user_manager.dart';

import 'model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rxVMS',
      debugShowCheckedModeBanner: false,
      home: RxVMSApp(),
    );
  }
}

class RxVMSApp extends StatefulWidget {
  @override
  _RxVMSAppState createState() => _RxVMSAppState();
}

class _RxVMSAppState extends State<RxVMSApp> {
  UserManager userManager;

  @override
  void initState() {
    userManager = UserManager();
    super.initState();
  }

  @override
  void dispose() {
    userManager = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RxVMS'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Container(
            // color: Colors.teal,
            padding: EdgeInsets.only(right: 10.0),
            child: Chip(
              label: StreamBuilder<int>(
                  stream: userManager.userCounter,
                  builder: (context, snapshot) {
                    String count = (snapshot.data ?? 0).toString();
                    return Text(count, style: TextStyle(color: Colors.white));
                  }),
              elevation: 0.0,
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: userListPage(),
    );
  }

  Widget userListPage() {
    return StreamBuilder(
      stream: userManager.getUserList,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  User user = snapshot.data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.picture),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                  );
                });
        }
        return null;
      },
    );
  }
}
