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
        height: 600,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(color: AppStyle.bgColor.withOpacity(1.0)),
        child: Column(
          children: [
            buildTitleBar(),
            SizedBox(height: 20),
            buildScoreBoard(),
            SizedBox(height: 20),
            changeUsername(),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(allScores.length, (index) {
                    return buildScoreRow(index + 1, allScores[index]);
                  }),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildScoreRow(int rank, Score score) {
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
            flex: 2,
            child: Text(
              '$rank',
              style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              (score.username == null || score.username!.isEmpty) ? 'Unknown' : score.username!,
              style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
              overflow: TextOverflow.ellipsis,
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
            flex: 2,
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

  Widget buildTitleBar() {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text('S C O R E  B O A R D',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Align(
            alignment: Alignment(1, 0),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget changeUsername() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () async {
          String? username = await usernameDialog();
          if (username != null) {
            await ScoreBoard().updateUsername(username);
            setState(() {});
          }
        },
        child: Text(
          'Change my name',
          style: TextStyle(fontSize: 14, color: AppStyle.accentColor),
        ),
      ),
    );
  }

  Future<String?> usernameDialog() async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: AppSettings.username);
        return AlertDialog(
          backgroundColor: AppStyle.bgColor,
          title: Text(r'What is your name?',
              style: TextStyle(fontSize: 18, color: AppStyle.lightTextColor, fontWeight: FontWeight.bold)),
          content: Container(
            decoration: BoxDecoration(
              color: AppStyle.bgColorWeak,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (value) => Navigator.of(context).pop(controller.text),
              style: TextStyle(
                color: AppStyle.accentColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
