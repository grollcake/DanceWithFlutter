import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class UpperSection extends StatelessWidget {
  const UpperSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SLIDING PUZZLE',
          style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
