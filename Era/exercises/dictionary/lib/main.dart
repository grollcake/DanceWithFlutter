import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionalry',
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: DictionaryApp(title: 'Dictionary'),
    );
  }
}

class DictionaryApp extends StatefulWidget {
  final String title;

  const DictionaryApp({Key key, this.title}) : super(key: key);

  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  final String _url = "https://owlbot.info/api/v4/dictionary/";
  final String _token = "20494ad45f0f9c416abe2576c9793657e0ab1d6c";
  TextEditingController _tc;
  StreamController _sc;
  Timer _debounce;

  _search() async {
    FocusScope.of(context).unfocus();

    if (_tc.text == null || _tc.text.trim().length == 0) {
      _sc.add(null);
      return;
    }

    _sc.add('WAITING');
    await Future.delayed(Duration(seconds: 3));

    final String fetchUrl = _url + _tc.text;
    http.Response res = await http.get(fetchUrl, headers: {'Authorization': 'Token $_token'});
    if (res.statusCode != 200) {
      _sc.add('ERROR: ${res.statusCode}');
    } else {
      var jsonData = json.decode(res.body);
      print(jsonData);
      _sc.add(jsonData);
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
//        backgroundColor: Colors.grey,
          title: Text(widget.title),
          centerTitle: true,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _tc,
                        onChanged: (String s) {
                          if (_debounce?.isActive ?? false) {
                            _debounce.cancel();
                            print('Timer canceled for $s');
                          }

                          if (s.trim().length != 0) {
                            _debounce = Timer(const Duration(milliseconds: 1500), () {
                              _search();
                            });
                            print('Timer started for $s');
                          }
                        },
                        decoration: InputDecoration(
                          hintText: '검색어 입력하세요',
                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            child: StreamBuilder(
                stream: _sc.stream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text('무엇이 궁금하세요?', style: TextStyle(fontSize: 18.0)),
                    );
                  } else if (snapshot.data == 'WAITING') {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data.toString().startsWith('ERROR')) {
                    return Center(
                      child: Text(snapshot.data, style: TextStyle(fontSize: 18.0)),
                    );
                  } else {
                    var jsonDatas = snapshot.data['definitions'];
                    return ListView.builder(
                        itemCount: jsonDatas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListBody(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(8.0),
                                color: Colors.grey[300],
                                child: ListTile(
                                  leading: jsonDatas[index]['image_url'] == null
                                      ? null
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(jsonDatas[index]['image_url']),
                                        ),
                                  title: Text(_tc.text + '(' + jsonDatas[index]['type'] + ')'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(jsonDatas[index]['definition']),
                              ),
                            ],
                          );
                        });
                  }
                }),
          ),
        ));
  }
}
