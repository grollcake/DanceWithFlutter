import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          context.read<GameController>().testShuffle();
        },
        icon: Icon(Icons.mode_night, size: 26, color: AppStyle.inactiveTextColor),
      ),
    );
  }
}
