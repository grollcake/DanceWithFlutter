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
  ScrollController _scrollController;

  @override
  void initState() {
    userManager = UserManager()..getUsers();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final _scrollThreshold = 50.0;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        print('Bottom of list');
        userManager.getUsers();
      }
    });
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
          icon: Icon(Icons.cloud_download),
          onPressed: () => userManager.getUsers(),
        ),
        actions: [
          Container(
            // color: Colors.teal,
            padding: EdgeInsets.only(right: 10.0),
            child: Chip(
              // label: Text('0'),
              label: StreamBuilder<List<User>>(
                  stream: userManager.userList,
                  builder: (context, snapshot) {
                    String count = (snapshot.data?.length ?? 0).toString();
                    return Text(count, style: TextStyle(color: Colors.white));
                  },
              ),
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
    return StreamBuilder<List<User>>(
      stream: userManager.userList,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        print('connectionState: ${snapshot.connectionState}  data: ${snapshot.data?.length}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.separated(
              controller: _scrollController,
                itemCount: snapshot.data.length + (userManager.isFetching ? 1:0),
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data.length) {
                    return Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else {
                    User user = snapshot.data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.picture),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: Text('#${index + 1}', style: TextStyle(fontStyle: FontStyle.italic)),
                    );
                  }
                });
        }
        return null;
      },
    );
  }
}
