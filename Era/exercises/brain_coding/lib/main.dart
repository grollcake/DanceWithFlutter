import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple counter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(title: '간단 증감기'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _number = 0;

  void numberCalc(int i) {
    setState(() {
      _number += i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('이만큼 눌렀어요', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 10.0),
              Text('$_number', style: TextStyle(fontSize: 30.0, color: _number >= 0 ? Colors.black : Colors.red[600])),
            ],
          ),
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => numberCalc(1),
            child: Icon(Icons.add),
            tooltip: '더하기',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => numberCalc(-1),
            child: Icon(Icons.remove),
            tooltip: '빼기',
          ),
        ],
      ),
      );
  }
}