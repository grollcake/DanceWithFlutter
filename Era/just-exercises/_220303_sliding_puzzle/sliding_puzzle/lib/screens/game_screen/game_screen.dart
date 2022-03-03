import 'package:flutter/material.dart';
import 'package:sliding_puzzle/screens/game_screen/components/puzzle_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: SafeArea(
          child: Column(
            children: [
              Text('SLIDING PUZZLE'),
              SizedBox(height: 20),
              Center(child: PuzzleBoard()),
            ],
          ),
        ),
      ),
    );
  }
}
