import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Color bgcolor;
  final Color color;
  final String btnText;
  final Function callBack;

  const CalcButton({Key key, this.bgcolor, this.color, this.btnText, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: this.callBack,
        child: Text(this.btnText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: this.color)),
        color: this.bgcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
