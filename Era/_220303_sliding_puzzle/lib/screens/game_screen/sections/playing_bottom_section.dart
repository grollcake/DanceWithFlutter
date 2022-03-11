import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/screens/game_screen/widgets/playing_info.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

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
          return Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(constraints.maxHeight * .1),
              image: DecorationImage(image: AssetImage(imagePath)),
            ),
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
      ),
    );
  }
}
