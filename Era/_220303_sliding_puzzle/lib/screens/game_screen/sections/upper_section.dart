import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class UpperSection extends StatelessWidget {
  const UpperSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameStatue = context.select((GameController controller) => controller.gameStatus);
    Widget contents;

    switch (gameStatue) {
      case GameStatus.ready:
        contents = buildReadyContents();
        break;
      case GameStatus.starting:
        contents = buildStartingContents();
        break;
      case GameStatus.playing:
        contents = buildPlayingContents(context);
        break;
      case GameStatus.completed:
        contents = buildCompletedContents();
        break;
    }

    return SizedBox.expand(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        // color: Colors.blueGrey,
        child: contents,
      ),
    );
  }

  Widget buildReadyContents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'SLIDING PUZZLE',
          style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildStartingContents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Get ready',
          style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildPlayingContents(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/animations/girl-tapping-phone.json'),
    );
  }

  Widget buildCompletedContents() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Completed!', style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold)),
        Expanded(
          child: Lottie.asset('assets/animations/clapping.json'),
        ),
      ],
    );
  }
}
