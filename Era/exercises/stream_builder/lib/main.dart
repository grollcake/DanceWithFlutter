import 'package:flutter/material.dart';
import 'package:stream_builder/counter_stream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamStudy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Homepage(title: 'Simple Timer'),
    );
  }
}

class Homepage extends StatefulWidget {
  final String title;

  Homepage({this.title});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CounterStream _counterStream = CounterStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('이만큼 시간이 지났어요:', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10),
            StreamBuilder<String>(
              stream: _counterStream.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('시작을 누르세요', style: TextStyle(fontSize: 24.0));
                } else {
                  return Text('${snapshot.data}초', style: TextStyle(fontSize: 24.0));
                }
              }
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: '시작',
            child: Icon(_counterStream.status ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _counterStream.status ? _counterStream.stopCounter(): _counterStream.startCounter();
              });
            },
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            tooltip: '감소',
            child: Icon(Icons.restore),
            onPressed: () {
              setState(() {
                _counterStream.resetCounter();
              });
            },
          ),
        ],
      ),
    );
  }
}