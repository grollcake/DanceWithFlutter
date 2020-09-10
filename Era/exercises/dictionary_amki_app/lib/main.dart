import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: DictionaryApp(),
    );
  }
}

class DictionaryApp extends StatefulWidget {
  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  TextEditingController _tc;
  StreamController _sc;
  final String _url = "https://owlbot.info/api/v4/dictionary/";
  final String _token = "20494ad45f0f9c416abe2576c9793657e0ab1d6c";
  Timer _debounce;

  _search() async {
    _debounce?.cancel();

    final String q = _tc.text.trim();
    if (q.length == 0) {
      _sc.add(null);
    }
    else {
      _sc.add('waiting');
      await Future.delayed(Duration(milliseconds: 1500));
      final String fetchUrl = _url + q;
      http.Response res = await http.get(fetchUrl, headers: {'Authorization': 'Token $_token'});
      if (res.statusCode != 200) {
        _sc.add('ERROR: ${res.statusCode}');
      }
      else {
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
        title: Text('Dictionary'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.teal,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 200.0,
                  child: TextField(
                    onChanged: (String s) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      if (s.trim().length != 0) {
                        _debounce = Timer(Duration(seconds: 2), _search);
                      }
                    },
                    onSubmitted: (String s) {
                      FocusScope.of(context).unfocus();
                      _search();
                    },
                    controller: _tc,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      hintText: '검색어를 입력하세요',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _search();
                  },
                )
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
              return Center(child: Text('검색어를 입력하세요'));
            }
            else if (snapshot.data == 'waiting') {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.data.toString().startsWith('ERROR')) {
              return Center(child: Text(snapshot.data, style: TextStyle(color: Colors.red)));
            }
            else {
              final jsonArr = snapshot.data['definitions'];
              return ListView.builder(
                itemCount: jsonArr.length,
                itemBuilder: (BuildContext context, int index) {
                  final jsonItem = jsonArr[index];
                  return ListBody(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        color: Colors.grey[200],
                        child: ListTile(
                          leading: jsonItem['image_url'] == null ? null : CircleAvatar(
                            backgroundImage: NetworkImage(jsonItem['image_url']),
                          ),
                          title: Text(_tc.text.trim() + '(' + jsonItem['type'] + ')'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 20, right: 10, top: 10),
                        child: Text(jsonItem['definition']),
                      )
                    ],
                  );
                }
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}

