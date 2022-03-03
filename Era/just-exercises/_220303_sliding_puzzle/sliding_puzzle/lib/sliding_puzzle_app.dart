import 'package:flutter/material.dart';
import 'package:sliding_puzzle/screens/game_screen/game_screen.dart';

class SlidingPuzzleApp extends StatelessWidget {
  const SlidingPuzzleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliding puzzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: GameScreen(),
    );
  }
}
