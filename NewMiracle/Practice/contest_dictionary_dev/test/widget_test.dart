import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "d50f05de86f946081f8f48dd31af79332a404de8";

  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if(_controller.text == 'null' || _controller.text.length == 0){
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response res = await get(_url + _controller.text.trim(),
        headers: {"Authorization" : "Token "+ _token});
    _streamController.add(json.decode(res.body));
  }

  @override
  void initState(){
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title : Text("Flictinary"),
            bottom : PreferredSize(
                preferredSize: Size.fromHeight(48),
                child : Row(
                  children: [
                    Expanded(
                        child : Container(
                          margin : EdgeInsets.only(left : 12, bottom : 8),
                          decoration: BoxDecoration(
                            color : Colors.white,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: TextFormField(
                            onChanged: (String text){
                              if(_debounce?.isActive ?? false) _debounce.cancel();
                              _debounce = Timer(Duration(milliseconds: 1000),(){
                                _search();
                              });
                            },
                            controller: _controller,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                hintText: "Enter a search word",
                                border: InputBorder.none
                            ),
                          ),
                        )
                    ),
                    IconButton(
                      icon : Icon(Icons.search, color : Colors.white),
                      onPressed: (){
                        _search();
                      },
                    )
                  ],
                )
            )
        ),
        body : Container(
            child : StreamBuilder(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot){

                if(snapshot.data == null){
                  return Center(
                    child : Text("Enter a search word"),
                  );
                }

                if(snapshot.data == "waiting"){
                  return Center(
                    child : CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount : snapshot.data["definitions"].length,
                    itemBuilder: (BuildContext context, int index){
                      return ListBody(
                        children: [
                          Container(
                              color : Colors.grey[300],
                              margin : EdgeInsets.only(left : 8),
                              child : ListTile(
                                leading: snapshot.data["definitions"][index]["image_url"] == null
                                    ? null
                                    : CircleAvatar(backgroundImage: NetworkImage(snapshot.data["definitions"][index]["image_url"])),
                                title : Text(_controller.text.trim()+"("+
                                    snapshot.data["definitions"][index]["type"] + ")"),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.all(8),
                              child : Text(snapshot.data["definitions"][index]["definition"])
                          )
                        ],
                      );
                    });
              },
            )
        )
    );
  }
}
