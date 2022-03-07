import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class PlayingBottomSection extends StatelessWidget {
  const PlayingBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildPlayInfo(context),
        buildRestart(context),
      ],
    );
  }

  Widget buildPlayInfo(BuildContext context) {
    final moves = context.select((GameController controller) => controller.moveCount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Row(
          children: [
            Text(
              'Moves   ',
              style: TextStyle(fontSize: 14, color: AppStyle.inactiveTextColor),
            ),
            Text(
              '$moves',
              style: TextStyle(fontSize: 14, color: AppStyle.textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Time   ',
              style: TextStyle(fontSize: 14, color: AppStyle.inactiveTextColor),
            ),
            StreamBuilder(
              stream: context.select((GameController controller) => controller.elapsedTimeStream),
              initialData: '00:00',
              builder: (BuildContext context, AsyncSnapshot snapshot) => Text(
                snapshot.data,
                style: TextStyle(fontSize: 14, color: AppStyle.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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
