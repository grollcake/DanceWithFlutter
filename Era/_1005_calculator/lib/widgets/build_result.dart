import 'package:flutter/material.dart';

class BuildResult extends StatelessWidget {
  const BuildResult({Key? key, required this.result}) : super(key: key);

  final double result;

  @override
  Widget build(BuildContext context) {
    String bgText = '8888888888.8';

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Text(
          bgText,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'AlarmClock',
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.withOpacity(.1),
          ),
        ),
        Text(
          result.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontFamily: 'AlarmClock',
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
