import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Color bgcolor, color;
  final String text;
  final Function callBack;

  const CalcButton({Key key, this.bgcolor, this.color, this.text, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        child: Text(text, style: TextStyle(color: color, fontSize: 20.0, fontWeight: FontWeight.bold),),
        onPressed: callBack,
        color: bgcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }
}