import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Color color, bgcolor;
  final String text;
  final Function callback;

  const CalcButton({Key key, this.color, this.bgcolor, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: FlatButton(
        onPressed: callback,
        child: Text(text, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: color)),
        color: bgcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
      ),
    );
  }
}