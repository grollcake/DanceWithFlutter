import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/scoreboard.dart';
import 'package:tetris/models/score.dart';

class SettingsDetailAbout extends StatefulWidget {
  const SettingsDetailAbout({Key? key}) : super(key: key);

  @override
  _SettingsDetailAboutState createState() => _SettingsDetailAboutState();
}

class _SettingsDetailAboutState extends State<SettingsDetailAbout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              AppSettings.username = '찬별화이팅!';
              ScoreBoard().updateScore(score: 100, level: 2);
            },
            child: Text('Add new data')),
        ElevatedButton(
            onPressed: () async {
              List<Score> allScores = await ScoreBoard().fetchAllScores();
              for (var e in allScores) {
                print('${e.username} - ${e.userId} - ${e.score} - ${e.level}');
              }
            },
            child: Text('Query all')),
      ],
    );
  }
}
