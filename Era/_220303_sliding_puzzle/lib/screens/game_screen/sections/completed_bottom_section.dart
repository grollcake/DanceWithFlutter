import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/common_widgets/primary_button.dart';
import 'package:sliding_puzzle/managers/game_controller.dart';
import 'package:sliding_puzzle/screens/game_screen/widgets/playing_info.dart';

class CompletedBottomSection extends StatelessWidget {
  const CompletedBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PlayingInfo(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PrimaryButton(label: 'SHARE', onPressed: () {}),
            PrimaryButton(
              label: 'Restart',
              onPressed: () {
                context.read<GameController>().resetGame();
              },
            ),
          ],
        ),
      ],
    );
  }
}
