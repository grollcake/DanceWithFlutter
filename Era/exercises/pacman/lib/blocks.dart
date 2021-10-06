import 'package:flutter/material.dart';

class WallBlock extends StatelessWidget {
  final String text;

  const WallBlock({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(4),
            color: Colors.blue[800],
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(padding: EdgeInsets.all(4), color: Colors.blue[900], child: Center(child: Text(text)))),
          )),
    );
  }
}
