import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "0aefa7c6866139483bff94c04e1020ca011e9200";

  TextEditingController _controller = TextEditingController();

  late StreamController _streamController;
  late Stream _stream;
  late Timer _debounce;

  _search() async{

    print(Uri.parse(_url + _controller.text.trim()));
    print("Token " + _token);

    if(_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    
    Response response = await get(Uri.parse(_url + _controller.text.trim()), headers: { "Authorization" : "Token " + _token });
    _streamController.add(json.decode(response.body));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Flictinoary"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0)
                  ),
                  child: TextFormField(
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(microseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search for a word',
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _search();
                  }
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            print("print!");
            print(snapshot.data);

            if(snapshot.data == null){
              return Center(
                child: Text("Enter a search word"),
              );
            }

            if(snapshot.data == "waiting") {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext ctx, int index){
                return ListBody(
                  children: [
                    Container(
                      color: Colors.grey.shade300,
                      child: ListTile(
                        leading: snapshot.data["definitions"][index]["image_url"] == null ? null : CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data["definitions"][index]["image_url"]),
                        ),
                        title: Text(_controller.text.trim() + "(" + snapshot.data["definitions"][index]["type"] + ")"),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data["definitions"][index]["definition"]),
                    )
                  ],
                );
              },
            );

          },
        ),
      ),
    );
  }
}
