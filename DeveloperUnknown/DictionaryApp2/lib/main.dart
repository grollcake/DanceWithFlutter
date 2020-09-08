import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  StreamController _streamController;
  Stream _stream;
  TextEditingController _controller = TextEditingController();

  final String _url = "https://owlbot.info/api/v4/dictionary/";
  final String _token = "d04b6a392025f4e73d95282eab32ebd05c9ce177";

  Timer _debounce;

  _search() async {
    if(_controller.text.trim() == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response res = await get(_url + _controller.text.trim(), headers: {"Authorization" : "Token " + _token});
    if (res.statusCode == 200 ) _streamController.add(json.decode(res.body));
    else _streamController.add("not found");
  }

  initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("doc app"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: TextFormField(
                    onChanged: (String x) {
                      if(_debounce ?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Input word for search",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 24)
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white,), 
                onPressed: _search
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null) {
              return Center(child: Text("Input word"));
            } else if (snapshot.data == "waiting") {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == "not found") {
              return Center(child: Text("not found"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data["definitions"].length,
                itemBuilder: (BuildContext context, int index) {
                  return ListBody(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        child: ListTile(
                          leading: snapshot.data["definitions"][index]["image"] == null ? null : CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data["definitions"][index]["image"]),
                          ),
                          title: Text(_controller.text.trim() + "(" + snapshot.data["definitions"][index]["type"] + ")"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data["definitions"][index]["definition"]),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}