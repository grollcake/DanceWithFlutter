import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '암기 코딩',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Homepage(title: '암기 코딩'),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _counter = 0;

  void _calcNumber(int i) {
    setState(() {
      _counter += i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('이만큼 눌렀어요', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10.0),
            Text('$_counter', style: TextStyle(fontSize: 30.0, color: _counter >= 0 ? Colors.black : Colors.redAccent)),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _calcNumber(1),
            child: Icon(Icons.add),
            tooltip: '더하기',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => _calcNumber(-1),
            child: Icon(Icons.remove),
            tooltip: '빼기',
          ),
        ],
      )
    );
  }
}