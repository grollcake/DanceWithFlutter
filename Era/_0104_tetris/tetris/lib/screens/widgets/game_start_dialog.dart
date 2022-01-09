import 'package:flutter/material.dart';

class GameStartDialog extends StatelessWidget {
  const GameStartDialog({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Align(alignment: Alignment.center, child: Text('Let\'s play Tetris')),
      // content: Text('Just for fun'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              },
              child: Text('Start')),
        ),
      ],
    );
  }
}
