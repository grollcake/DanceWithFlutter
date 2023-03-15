import 'package:flutter/material.dart';

import '../constants/styles.dart';

class Shinny extends StatelessWidget {
  final bool active;

  const Shinny({Key? key, this.active = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        active
            ? Image.asset('assets/icons/shinny.png', width: 32)
            : Image.asset('assets/icons/shinny.png', width: 32, color: Colors.white),
        FittedBox(
          child: Text(
            'Shinny',
            style: TextStyle(
              fontSize: 14,
              color: active ? primaryColor : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
