import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/common_widgets/primary_button.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class ReadyBottomSection extends StatelessWidget {
  ReadyBottomSection({Key? key}) : super(key: key);

  final levelDimensions = [3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            levelDimensions.length,
            (index) => buildDimensionSelection(context, levelDimensions[index]),
          ),
        ),
        SizedBox(height: 10),
        PrimaryButton(
          label: 'START',
          onPressed: () {
            final gameController = context.read<GameController>();
            gameController.startGame();
          },
        ),
      ],
    );
  }

  Widget buildDimensionSelection(BuildContext context, int dimension) {
    final gameController = context.watch<GameController>();
    final textColor = dimension == gameController.puzzleDimension ? AppStyle.textColor : AppStyle.inactiveTextColor;
    final weight = dimension == gameController.puzzleDimension ? FontWeight.w700 : FontWeight.w400;

    return GestureDetector(
      onTap: () {
        gameController.setPuzzleDimension(dimension);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          '$dimension x $dimension',
          style: TextStyle(fontSize: 14, color: textColor, fontWeight: weight),
        ),
      ),
    );
  }
}
