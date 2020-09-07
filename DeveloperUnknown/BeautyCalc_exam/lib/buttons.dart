import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final color;
  final textColor;
  final ontapped;

  MyButton({this.text, this.color, this.ontapped, this.textColor});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(child: Text(text, style: TextStyle(color: textColor, fontSize: 20, decoration: TextDecoration.none),)),
          ),
        ),
      ),
    );
  }
}