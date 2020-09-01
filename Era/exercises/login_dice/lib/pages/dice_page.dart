import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dice'),
          backgroundColor: Colors.redAccent[300],
        ),
        backgroundColor: Colors.redAccent[100],
        body: DicePageBody());
  }
}

class DicePageBody extends StatefulWidget {
  @override
  _DicePageBodyState createState() => _DicePageBodyState();
}

class _DicePageBodyState extends State<DicePageBody> {
  int _leftDice;
  int _rightDice;

  @override
  void initState() {
    _leftDice = 1;
    _rightDice = 1;
    super.initState();
  }

  void _playDice(BuildContext context) {
    setState(() {
      _leftDice = Random().nextInt(6) + 1;
      _rightDice = Random().nextInt(6) + 1;
    });
    _showToast(context);
  }

  void _showToast(BuildContext context) {
    Toast.show(
      "Left dice: $_leftDice, Right dice: $_rightDice",
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(child: Image(image: AssetImage('images/dice$_leftDice.png'))),
              SizedBox(width: 30.0),
              Expanded(child: Image(image: AssetImage('images/dice$_rightDice.png'))),
            ],
          ),
          SizedBox(height: 50.0),
          FlatButton(
            onPressed: () => _playDice(context),
            color: Colors.amberAccent,
            child: Text('Play!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
