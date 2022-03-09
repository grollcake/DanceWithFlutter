import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/screens/game_screen/widgets/playing_info.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class PlayingBottomSection extends StatelessWidget {
  const PlayingBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PlayingInfo(),
        buildRestart(context),
      ],
    );
  }

  Widget buildRestart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Got stuck? ', style: TextStyle(fontSize: 14, color: AppStyle.inactiveTextColor)),
        TextButton(
          onPressed: () {
            context.read<GameController>().resetGame();
          },
          child: Text(
            'Restart',
            style: TextStyle(fontSize: 14, color: AppStyle.textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
