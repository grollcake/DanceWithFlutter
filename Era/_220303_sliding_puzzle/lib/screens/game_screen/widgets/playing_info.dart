import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class PlayingInfo extends StatelessWidget {
  const PlayingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontSize: 17, color: AppStyle.inactiveTextColor),
            ),
            Text(
              '$moves',
              style: TextStyle(fontSize: 18, color: AppStyle.textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Time   ',
              style: TextStyle(fontSize: 17, color: AppStyle.inactiveTextColor),
            ),
            StreamBuilder(
              stream: context.select((GameController controller) => controller.elapsedTimeStream),
              initialData: '00:00',
              builder: (BuildContext context, AsyncSnapshot snapshot) => Text(
                snapshot.data,
                style: TextStyle(fontSize: 18, color: AppStyle.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
