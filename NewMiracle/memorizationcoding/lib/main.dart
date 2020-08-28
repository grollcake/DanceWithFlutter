import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '카운터 데모',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Homepage(title: '데모'),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final String title;

  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _counter = 0;
  void _calcCounter(int i) {
    setState(() {
      _counter += i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('이만큼 눌렀어요', style: TextStyle(fontSize: 20.0)),
          SizedBox(width: 10.0),
          Text('$_counter', style: TextStyle(fontSize: 24.0)),
        ],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _calcCounter(1),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => _calcCounter(-1),
            child: Icon(Icons.remove),
          ),
        ],
      ),

    );
  }
}