import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext c) {
    return MaterialApp(
      title: "Calc App",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.red,
      ),
      home : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _string = "";
  bool lastCalc = false;
  void _clickButton(String context) {
    setState(() {
      if(context == "AC") {
        _string = "";
      } else if(context == "/" || context == "*" || context == "+" || context == "-") {
        if(_string.length == 0 ) {
          return;
        } else if(lastCalc) {
          _string = _string.substring(0, _string.length-1) + context;
        } else {
          _string += context;
          lastCalc = true;
        }
      } else if(context == "C") {
        if(context.length == 0) return;
        _string = _string.substring(0, _string.length-1);
      } else {
        _string += context;
        lastCalc = false;
      }
    });
  }
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calc App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text("$_string", 
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _createButtonPad(),
            ),
          ],
        ),
      ),
    );
  }


  Widget _createButtonPad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("AC", 1),
              _createButton("/", 1),
              _createButton("*", 1),
              _createButton("C", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("1", 1),
              _createButton("2", 1),
              _createButton("3", 1),
              _createButton("+", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("4", 1),
              _createButton("5", 1),
              _createButton("6", 1),
              _createButton("-", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("7", 1),
              _createButton("8", 1),
              _createButton("9", 1),
              _createButton(".", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton(".", 1),
              _createButton("0", 1),
              _createButton("00", 1),
              _createButton("=", 1),
            ],
          )
        ),
      ],
    );
  }

  Widget _createButton(String context, int flex) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        child: Text("$context",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        onPressed: () => _clickButton(context),
      ),
    );
  }
}