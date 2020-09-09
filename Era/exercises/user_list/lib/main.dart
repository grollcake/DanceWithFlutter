import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_list/model/user_model.dart';

enum FetchStatus { fetching, done, error }

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UserList',
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: UserListApp(),
    );
  }
}

class UserListApp extends StatefulWidget {
  @override
  _UserListAppState createState() => _UserListAppState();
}

class _UserListAppState extends State<UserListApp> {
  final String _url = 'https://randomuser.me/api/?page={PAGE}&results=10&seed=Era';
  int _pageNo = 0;
  List<UserModel> _usermodels = List<UserModel>();
  StreamController<FetchStatus> _sc;
  StreamController<int> _counter;
  ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  @override
  void initState() {
    _sc = StreamController<FetchStatus>();
    _counter = StreamController<int>();
    _fetchUsers();

    _scrollController.addListener(() {
      final _scrollThreshold = 50.0;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        print('triggerd');
        _fetchUsers();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _sc.close();
    super.dispose();
  }

  _fetchUsers() async {
    if (_isFetching) {
      print('Already fetching');
      return;
    }
    _isFetching = true;

    final String fetchUrl = _url.replaceFirst('{PAGE}', (++_pageNo).toString());

    _sc.add(FetchStatus.fetching);

    await Future.delayed(Duration(seconds: 2));
    http.Response res = await http.get(fetchUrl);

    print('fetchUrl: $fetchUrl, status: ${res.statusCode}');

    if (res.statusCode != 200) {
      _sc.add(FetchStatus.error);
      _isFetching = false;
      return;
    }

    var userArr = json.decode(res.body)['results'];
    for (var user in userArr) {
      UserModel userModel = UserModel(name: user['name']['first'] + ' ' + user['name']['last'], email: user['email'], image: user['picture']['medium']);

//      print(userModel.toString());
      _usermodels.add(userModel);
    }

    _sc.add(FetchStatus.done);
    _counter.add(_usermodels.length);
    print('total count: ${_usermodels.length}');
    _isFetching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserList'),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          StreamBuilder<int>(
              stream: _counter.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Chip(
                    label: Text(snapshot.data.toString(), style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.redAccent,
                  );
                } else {
                  return Container();
                }
              }),
          SizedBox(width: 10)
        ],
      ),
      body: userListBody(),
    );
  }

  Widget userListBody() {
    return Container(
//      color: Colors.green,
      margin: EdgeInsets.all(8),
      child: StreamBuilder(
          stream: _sc.stream,
          builder: (BuildContext context, AsyncSnapshot<FetchStatus> snapshot) {
            print('connectionState: ${snapshot.connectionState}, snapshot: ${snapshot.data}');
            if (_usermodels.length == 0) {
              return Center(child: CircularProgressIndicator());
            } else if (_usermodels.length > 0) {
              return ListView.separated(
                  controller: _scrollController,
                  itemCount: _usermodels.length + (snapshot.data == FetchStatus.fetching ? 1 : 0),
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data == FetchStatus.fetching && index == _usermodels.length) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      var um = _usermodels[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(um.image),
                        ),
                        title: Text(um.name),
                        subtitle: Text(um.email),
                        trailing: Container(
                          width: 70.0,
                          child: Row(
                            children: <Widget>[
                              Text('#' + (index + 1).toString(), style: TextStyle(fontSize: 10.0)),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios, color: Colors.amber),
                                onPressed: () => print(um.toString()),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('ListTile on ${um.name} tapped');
                        },
                      );
                    }
                  });
            }
            return Container();
          }),
    );
  }
}
