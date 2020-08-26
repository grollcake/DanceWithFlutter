import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Calculator')),
        body: Homepage(),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _displayString = '0';

  void _buttonAction(String btn) {
    if (btn == 'CLEAR') {
      setState(() {
        _displayString = '0';
      });
    } else {
      setState(() {
        _displayString += btn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Text(_displayString,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)
            )
        ),
        Expanded(child: SizedBox(height: 10)),
        Row(
          children: [
            CalcButton(text: '7', action: _buttonAction),
            CalcButton(text: '8', action: _buttonAction),
            CalcButton(text: '9', action: _buttonAction),
            CalcButton(text: '/', action: _buttonAction),
          ],
        ),
        Row(
          children: [
            CalcButton(text: '4', action: _buttonAction),
            CalcButton(text: '5', action: _buttonAction),
            CalcButton(text: '6', action: _buttonAction),
            CalcButton(text: 'X', action: _buttonAction),
          ],
        ),
        Row(
          children: [
            CalcButton(text: '1', action: _buttonAction),
            CalcButton(text: '2', action: _buttonAction),
            CalcButton(text: '3', action: _buttonAction),
            CalcButton(text: '-', action: _buttonAction),
          ],
        ),
        Row(
          children: [
            CalcButton(text: '.', action: _buttonAction),
            CalcButton(text: '0', action: _buttonAction),
            CalcButton(text: '00', action: _buttonAction),
            CalcButton(text: '+', action: _buttonAction),
          ],
        ),
        Row(
          children: [
            CalcButton(text: 'CLEAR', action: _buttonAction),
            CalcButton(text: '=', action: _buttonAction)],
        ),
      ],
    );
  }
}

class CalcButton extends StatelessWidget {
  String _btnText;
  Function _action;

  CalcButton({Key key, String text, Function action}) {
    this._btnText = text;
    this._action = action;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        onPressed: () => this._action(this._btnText),
        padding: EdgeInsets.all(12.0),
        child: Text(this._btnText, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
