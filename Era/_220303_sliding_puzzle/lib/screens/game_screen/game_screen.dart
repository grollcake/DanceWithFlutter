import 'package:flutter/material.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/puzzle_board.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/top_section.dart';

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
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopSection(),
              SizedBox(height: 20),
              PuzzleBoard(),
              SizedBox(height: 20),
              BottomSection(),
            ],
          ),
        ),
      ),
    );
  }
}
