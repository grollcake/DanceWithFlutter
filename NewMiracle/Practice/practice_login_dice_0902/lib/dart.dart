import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {

  int leftDice = 1;
  int rightDice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Game',textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Padding(padding: EdgeInsets.all(30.0),
            child : Row(
              children: [
                Expanded(child: Image.asset('image/dice$leftDice.png')),
                SizedBox(width:20.0),
                Expanded(child: Image.asset('image/dice$rightDice.png')),
              ],
            )
            ),
            SizedBox(height : 30.0),
            ButtonTheme(
              minWidth: 100.0,
              height : 40.0,
              child : RaisedButton(
                  child : Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: (){
                    setState(() {
                      leftDice = Random().nextInt(6) + 1;
                      rightDice = Random().nextInt(6) + 1;
                    });
                    showToast(
                      'left dice {$leftDice}, right dice {$rightDice}'
                    );
                  })

            )
          ],
        ),
      )
    );
  }
}

void showToast(String message){
  Fluttertoast.showToast(msg: message,
  backgroundColor: Colors.white,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM);
}

