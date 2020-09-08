import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dictionary'),
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
  final String _url = "https://owlbot.info/api/v4/dictionary/";
  final String _token = "20494ad45f0f9c416abe2576c9793657e0ab1d6c";
  TextEditingController _tc;
  StreamController _sc;
  Timer _debounce;

  _search() async {
    final String q = _tc.text.trim();
    _debounce?.cancel();

    if (q.length == 0) {
      _sc.add(null);
    } else {
      _sc.add('waiting');
      await Future.delayed(Duration(seconds: 1));
      final String fetchUrl = _url + q;
      http.Response res = await http.get(fetchUrl, headers: {'Authorization': 'Token $_token'});
      if (res.statusCode != 200) {
        _sc.add('ERROR: ${res.statusCode}');
      } else {
        final jsonData = json.decode(res.body);
        print(jsonData);
        _sc.add(jsonData);
      }
    }
  }

  @override
  void initState() {
    _tc = TextEditingController();
    _sc = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    _tc = null;
    _sc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(42),
          child: Container(
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  child: TextField(
                    onChanged: (s) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      if (s.trim().length > 0) _debounce = Timer(Duration(seconds: 2), _search);
                    },
                    keyboardType: TextInputType.name,
                    controller: _tc,
                    onSubmitted: (s) => _search(),
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      hintText: '무엇이 궁금해?',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      // border: InputBorder.none,
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                // SizedBox(width: 10.0),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _search();
                    },
                    icon: Icon(Icons.search, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: _sc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Center(child: Text('뭐라도 하나 검색해봐요'));
              } else if (snapshot.data == 'waiting') {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data.toString().startsWith('ERROR')) {
                return Center(child: Text(snapshot.data, style: TextStyle(color: Colors.redAccent)));
              } else {
                final jsonArray = snapshot.data['definitions'];
                return ListView.builder(
                    itemCount: jsonArray.length,
                    itemBuilder: (BuildContext context, int index) {
                      final jsonData = jsonArray[index];
                      return Container(
                        // color: Colors.green,
                        margin: EdgeInsets.all(8),
                        child: ListBody(
                          children: [
                            Container(
                              color: Colors.grey[300],
                              child: ListTile(
                                leading: jsonData['image_url'] == null
                                    ? null
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(jsonData['image_url']),
                                      ),
                                title: Text(_tc.text + '(' + jsonData['type'] + ')'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16, top: 5, bottom: 20),
                              child: Text(jsonData['definition']),
                            )
                          ],
                        ),
                      );
                    });
              }
              return null;
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
