import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/managers/game_controller.dart';
import 'package:sliding_puzzle/managers/theme_manager.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/screens/game_screen/widgets/playing_info.dart';
import 'package:sliding_puzzle/settings/app_style.dart';
import 'package:sliding_puzzle/utils/utils.dart';

class PlayingBottomSection extends StatelessWidget {
  const PlayingBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: PlayingInfo()),
        Expanded(flex: 3, child: buildImagePreview(context)),
        Expanded(flex: 1, child: buildRestart(context)),
      ],
    );
  }

  Widget buildImagePreview(BuildContext context) {
    final gameController = context.read<GameController>();

    // number일 경우에는 빈 화면만 나오도록 early return 처리
    if (gameController.gameMode == GameMode.number) return SizedBox();

    final imagePath = context.select((GameController controller) => controller.gameImage);

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(constraints.maxWidth * .1),
            child: Image.asset(getPreviewImagePath(imagePath), fit: BoxFit.fill),
          );
        },
      ),
    );
  }

  Widget buildRestart(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Got stuck? ', style: TextStyle(fontSize: 14, color: ThemeManager.inactiveColor)),
          TextButton(
            onPressed: () {
              context.read<GameController>().resetGame();
            },
            child: Text(
              'Restart',
              style: TextStyle(fontSize: 14, color: ThemeManager.textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
