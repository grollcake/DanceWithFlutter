import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final color;
  final colorText;
  final String buttonText;

  MyButton({this.color, this.colorText, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child : Container(
          color : color,
          child : Center(
            child :
              Text(buttonText , style : TextStyle(color : colorText),)
             )
      )
      ),
    );
  }
}
