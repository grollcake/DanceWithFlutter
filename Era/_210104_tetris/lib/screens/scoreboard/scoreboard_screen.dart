import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/scoreboard.dart';
import 'package:tetris/models/score.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({Key? key}) : super(key: key);

  @override
  _ScoreBoardScreenState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(color: AppStyle.bgColor.withOpacity(1.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: Center(
                child: Text('S C O R E  B O A R D',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            buildScoreBoard(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildScoreBoard() {
    ScoreBoard scoreBoard = ScoreBoard();
    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: scoreBoard.fetchAllScores(),
          builder: (BuildContext context, AsyncSnapshot<List<Score>> snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List<Score> allScores = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(allScores.length, (index) {
                  return buildScoreRow(index + 1, allScores[index]);
                }),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildScoreRow(int rank, Score score) {
    String dateString = '${score.dateTime!.year ~/ 100}.${score.dateTime!.month}.${score.dateTime!.day}';

    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: rank % 2 == 1 ? AppStyle.bgColorWeak : Colors.transparent,
          border: score.userId == AppSettings.userId
              ? Border.all(
                  color: AppStyle.accentColor,
                  width: 2.0,
                )
              : null),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$rank',
              style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              score.username ?? 'Unknown',
              style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${score.score ?? 0}',
              style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Lvl.${score.level}',
              style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
