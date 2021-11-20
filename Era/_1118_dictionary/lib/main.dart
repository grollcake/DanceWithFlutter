import 'dart:async';
import 'dart:convert';

import 'package:dictionary/services/owlbot.dart';
import 'package:flutter/material.dart';

void main() => runApp(DictionaryApp());

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owlbot Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  late StreamController<String> streamController;
  late Stream<String> stream;
  Timer? _timer;
  int receivedCount = 0;

  void search() {
    if (_controller.text.isEmpty) {
      streamController.sink.add('noKeyword');
      return;
    }

    streamController.sink.add('searching');

    owlBot(_controller.text).then((result) {
      if (result.startsWith('[E]')) {
        streamController.sink.addError(result);
      } else {
        streamController.sink.add(result);
      }
    });

    streamController.sink.add('searching');
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    streamController = StreamController();
    stream = streamController.stream;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owlbot dictionary'),
        centerTitle: true,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: (s) {
                      if (_timer?.isActive ?? false) _timer!.cancel();
                      _timer = Timer(Duration(seconds: 1), search);
                    },
                    onSubmitted: (string) => search(),
                    decoration: InputDecoration(
                      hintText: 'Search a word',
                      border: InputBorder.none,
                      isCollapsed: true, // Todo: 최소한의 높이로 지정
                      contentPadding: EdgeInsets.zero, // Todo: 최소한의 높이로 지정
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () => search(),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            receivedCount++;
            print(
                '[$receivedCount] snapshot status: connectionState=${snapshot.connectionState}, hasData=${snapshot.hasData}, error=${snapshot.error}');

            if (snapshot.hasData) {
              if (snapshot.data == 'noKeyword') {
                return Center(
                  child: Text('First, enter any keyword'),
                );
              } else if (snapshot.data == 'searching') {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: renderResult(_controller.text, snapshot.data),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something wrong: ${snapshot.error}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget renderResult(String keyword, String result) {
    var data = json.decode(result);

    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: data['definitions'].length,
        itemBuilder: (BuildContext context, int index) {
          var item = data['definitions'][index];
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(keyword,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      Text(item['type'],
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item['image_url'] != null)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(item['image_url']),
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          item['definition'],
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
