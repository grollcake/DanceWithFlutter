import 'package:flutter/material.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Counter App';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(appTitle: appTitle),
    );
  }
}


class HomePage extends StatefulWidget{
  final String appTitle;

  HomePage({this.appTitle});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _calcNumber(int num) {
    setState(() {
      _counter += num;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
      ),
      body: DisplayCounter(displayNumber: _counter),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _calcNumber(1),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => _calcNumber(-1),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}


class DisplayCounter extends StatelessWidget {
  final int displayNumber;

  DisplayCounter({this.displayNumber});

  @override
  Widget build(BuildContext context) {
    TextStyle _numberStyle = TextStyle(fontSize: 42.0);
    if (displayNumber >= 0) {
      _numberStyle = _numberStyle.apply(color: Colors.black);
    }
    else {
      _numberStyle = _numberStyle.apply(color: Colors.redAccent);
    }

    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text('+, -를 눌러보세요', style: TextStyle(fontSize: 24.0, color: Colors.grey[600])),
          SizedBox(height: 20.0),
          Text('$displayNumber', style: _numberStyle),
        ],
      ),
    );
  }
}


