import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class StartingCountdown extends StatefulWidget {
  const StartingCountdown({Key? key}) : super(key: key);

  @override
  State<StartingCountdown> createState() => _StartingCountdownState();
}

class _StartingCountdownState extends State<StartingCountdown> {
  final _animationDuration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _animateCountdown());
  }

  _animateCountdown() async {
    final gameController = context.read<GameController>();

    for (int i = 0; i < 3; i++) {
      gameController.shuffle();
      await Future.delayed(_animationDuration * 1.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: 160, color: AppStyle.primaryColor, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
        child: AnimatedTextKit(
          repeatForever: false,
          animatedTexts: [
            ScaleAnimatedText('2', duration: _animationDuration),
            ScaleAnimatedText('1', duration: _animationDuration),
            ScaleAnimatedText('Go', duration: _animationDuration),
          ],
          isRepeatingAnimation: false,
          onFinished: () {
            final gameController = context.read<GameController>();
            gameController.startGame();
          },
        ),
      ),
    );
  }
}
