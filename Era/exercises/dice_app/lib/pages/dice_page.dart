import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: DicePageBody());
  }
}

class DicePageBody extends StatefulWidget {
  @override
  _DicePageBodyState createState() => _DicePageBodyState();
}

class _DicePageBodyState extends State<DicePageBody> {
  int _leftDice= 1;
  int _rightDice = 1;

  void _dice() {
    setState(() {
      _leftDice = Random().nextInt(6) + 1;
      _rightDice = Random().nextInt(6) + 1;
    });

    Toast.show(
      'Left: $_leftDice, Right: $_rightDice'
      , context
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.asset('images/dice$_leftDice.png'),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Image.asset('images/dice$_rightDice.png'),
              ),
            ],
          ),
          SizedBox(height: 40.0),
          FlatButton(
            color: Colors.green,
            child: Icon(Icons.play_arrow, size: 30.0, color: Colors.yellow),
            onPressed: _dice,
          ),
        ],
      ),
    );
  }
}
