import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/managers/game_controller.dart';
import 'package:sliding_puzzle/managers/theme_manager.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();
    final IconData icon = themeManager.themeMode == ThemeMode.dark ? Icons.sunny : Icons.mode_night;
    return Container(
      height: 40,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          // final gameController = context.read<GameController>();
          // if (gameController.gameStatus == GameStatus.playing) {
          //   gameController.testShuffle();
          // }
          themeManager.toggleThemeMode();
        },
        icon: Icon(icon, size: 26),
      ),
    );
  }
}
