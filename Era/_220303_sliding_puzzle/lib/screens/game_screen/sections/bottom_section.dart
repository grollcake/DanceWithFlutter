import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';

class BottomSection extends StatelessWidget {
  BottomSection({Key? key}) : super(key: key);

  final levelDimensions = [3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                levelDimensions.length,
                (index) => buildLevelSelection(context, levelDimensions[index]),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(onPressed: () {
                  final gameController = context.read<GameController>();
                  gameController.resetGame();
                }, child: Text('RESET')),
              ),
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(onPressed: () {
                  final gameController = context.read<GameController>();
                  gameController.startGame();
                }, child: Text('START')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLevelSelection(BuildContext context, int dimension) {
    final gameController = context.watch<GameController>();

    return GestureDetector(
      onTap: () {
        gameController.setPuzzleDimension(dimension);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: gameController.puzzleDimension == dimension ? Colors.yellowAccent : Colors.white,
        ),
        child: Text('$dimension x $dimension',
            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
