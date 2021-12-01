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
    Response res = await  get(_url + _controller.text.trim(),
    headers: {"Authorization" : "Token " + _token});
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
        title : "Flictinary",
        bottom : PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(lef : 12, bottom : 8),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        )
      ),

    );
  }
}
