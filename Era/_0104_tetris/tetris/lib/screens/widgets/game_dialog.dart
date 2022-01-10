import 'dart:ui';

import 'package:flutter/material.dart';

class GameDialog extends StatelessWidget {
  const GameDialog({Key? key, required this.onPressed, required this.title, required this.btnText}) : super(key: key);
  final String title;
  final String btnText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: FittedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.white.withOpacity(0.05),
              elevation: 0.0,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                ),
              ),
              // content: Text('Just for fun'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onPressed();
                    },
                    child: Text(
                      btnText,
                      style: TextStyle(fontSize: 14, color: Colors.yellow),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
