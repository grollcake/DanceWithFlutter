import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/scoreboard_manager.dart';
import 'package:tetris/models/score.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({Key? key}) : super(key: key);

  @override
  _ScoreBoardScreenState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  late ScoreBoardManager scoreBoard;
  late ScrollController scrollController;
  late TextEditingController textEditingcontroller;
  var myScoreKey = GlobalKey();
  bool isValidUsername = false;

  AppSettings settings = AppSettings();

  @override
  void initState() {
    super.initState();
    scoreBoard = ScoreBoardManager();
    scrollController = ScrollController();
    textEditingcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textEditingcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasName = settings.username != null && settings.username!.isNotEmpty;
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
            hasName ? buildScoreBoard() : buildRequestUsername(),
            SizedBox(height: 20),
            if (hasName) changeUsername(),
          ],
        ),
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
            child: Text('S C O R E    B O A R D',
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

  Widget buildRequestUsername() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            const Text(
              'Want to see scoreboard?\nFirst, let me know your name.',
              style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppStyle.bgColorAccent,
              ),
              child: TextField(
                controller: textEditingcontroller,
                autofocus: true,
                style: TextStyle(color: AppStyle.accentColor),
                onChanged: (value) {
                  setState(() {
                    isValidUsername = value.isNotEmpty && value.trim().length > 0;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    isValidUsername = value.isNotEmpty && value.trim().length > 0;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Your name?',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 40),
              ),
              onPressed: isValidUsername
                  ? () async {
                      await setUsername(textEditingcontroller.text);
                      setState(() {});
                    }
                  : null,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScoreBoard() {
    return Expanded(
      child: StreamBuilder<List<Score>>(
        stream: scoreBoard.fetchAllScores(),
        builder: (BuildContext context, AsyncSnapshot<List<Score>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // 사용자의 점수가 제일 위에 나타나도록 스크롤 위치 조정
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              Scrollable.ensureVisible(myScoreKey.currentContext!);
            });
            List<Score> allScores = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(allScores.length, (index) => buildScoreRow(index + 1, allScores[index])),
                ),
              ),
            );
          } else if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: Lottie.asset('assets/animations/loading2.json', width: 250));
          } else {
            return Center(child: Text('Something wrong'));
          }
        },
      ),
    );
  }

  Widget buildScoreRow(int rank, Score score) {
    return Container(
      key: score.userId == settings.userId ? myScoreKey : null,
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: rank % 2 == 1 ? AppStyle.bgColorWeak : Colors.transparent,
          border: score.userId == settings.userId
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
              'Lvl.${score.stage}',
              style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor),
              textAlign: TextAlign.center,
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
        onPressed: () async => setUsername(await usernameDialog()),
        child: Text(
          'Change name',
          style: TextStyle(fontSize: 14, color: AppStyle.accentColor),
        ),
      ),
    );
  }

  Future<String?> usernameDialog() async {
    textEditingcontroller.text = settings.username ?? '';

    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppStyle.bgColor,
          content: Container(
            decoration: BoxDecoration(
              color: AppStyle.bgColorWeak,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: textEditingcontroller,
              autofocus: true,
              onSubmitted: (value) => Navigator.of(context).pop(textEditingcontroller.text),
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
              onPressed: () => Navigator.of(context).pop(textEditingcontroller.text),
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }

  Future<void> setUsername(String? name) async {
    if (name != null && name.isNotEmpty && name.trim().length > 0) {
      await ScoreBoardManager().updateUsername(name);
    }
  }
}
