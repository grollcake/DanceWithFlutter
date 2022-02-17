import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/gameplay_manager.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/modules/swipe_detector.dart';
import 'package:tetris/screens/gampeplay/components/pause_panel.dart';
import 'package:tetris/screens/gampeplay/components/tetris_panel.dart';
import 'package:tetris/screens/gampeplay/components/top_panel.dart';
import 'package:tetris/screens/scoreboard/scoreboard_screen.dart';
import 'package:tetris/screens/settings/settings_screen.dart';

class NewPlayScreen extends StatelessWidget {
  const NewPlayScreen({Key? key}) : super(key: key);

  void _showScoreBoardDialog(BuildContext context) async {
    final manager = context.read<GamePlayManager>();
    manager.pauseGame(eventForwarding: false);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ScoreBoardScreen();
      },
    );

    manager.resumeGame();
  }

  void _showMenuDialog(BuildContext context) async {
    final manager = context.read<GamePlayManager>();
    manager.pauseGame(eventForwarding: false);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SettingsScreen();
      },
    );

    manager.resumeGame();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('GamePlayScreen rebuilded');

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppStyle.bgColor,
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  // 투명한 AppBar 생성
  AppBar buildAppBar(BuildContext context) {
    print('AppBar builded');

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () async => _showScoreBoardDialog(context),
          icon: Icon(FontAwesomeIcons.trophy, size: 18, color: AppStyle.lightTextColor),
        ),
        IconButton(
          onPressed: () async => _showMenuDialog(context),
          icon: Icon(FontAwesomeIcons.bars, size: 18, color: AppStyle.lightTextColor),
        ),
      ],
    );
  }

  // 게임화면 생성
  Widget buildBody(BuildContext context) {
    print('buildBody called');

    final manager = context.read<GamePlayManager>();
    final backgroundImage = context.select((AppSettings settings) => settings.backgroundImage);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backgroundImage), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Spacer(),
          // 상단 상태 패널
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            height: 70,
            child: GameplayTopPanel(),
          ),
          SizedBox(height: 6),
          // 메인 게임 패널
          SwipeDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: GameplayTetrisPanel(),
            ),
            onTap: () => manager.rotateBlock(),
            onSwipeLeft: (int steps) => manager.moveBlock(MoveDirection.left, steps),
            onSwipeRight: (int steps) => manager.moveBlock(MoveDirection.right, steps),
            onSwipeUp: () => manager.holdBlock(),
            onSwipeDown: (int steps) => manager.moveBlock(MoveDirection.down, steps),
            onSwipeDrop: () => manager.dropBlock(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.centerRight,
            child: GamePlayPausePanel(),
          ),
        ],
      ),
    );
  }
}
