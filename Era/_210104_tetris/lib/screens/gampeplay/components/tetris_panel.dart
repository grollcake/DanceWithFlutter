import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/constants.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/gameplay_manager.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/modules/shaker_widget.dart';
import 'package:tetris/screens/gampeplay/widgets/gameend_dialog.dart';
import 'package:tetris/screens/widgets/game_dialog.dart';
import 'package:tetris/screens/widgets/tttile.dart';

class GameplayTetrisPanel extends StatefulWidget {
  const GameplayTetrisPanel({Key? key}) : super(key: key);

  @override
  State<GameplayTetrisPanel> createState() => _GameplayTetrisPanelState();
}

class _GameplayTetrisPanelState extends State<GameplayTetrisPanel> {
  GlobalKey<ShakeWidgetState> shakeKey = GlobalKey();
  late final GamePlayManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = context.read<GamePlayManager>();
    Future.delayed(Duration.zero, () => _manager.startGame());
    _manager.gamePlayEvents.listen((event) => _eventHandler(event));
  }

  void _eventHandler(GamePlayEvents event) {
    switch (event) {
      case GamePlayEvents.gameStarted:
        break;
      case GamePlayEvents.gamePaused:
        _pauseDialog();
        break;
      case GamePlayEvents.gameResumed:
        break;
      case GamePlayEvents.gameEnded:
        _gameendDialog();
        break;
      case GamePlayEvents.stageCleared:
        _stageClearDialog();
        break;
      case GamePlayEvents.blockDropped:
        shakeKey.currentState!.shake();
        break;
      case GamePlayEvents.gameEndDialogRecall:
        _gameendDialog(isRecall: true);
        break;
    }
  }

  void _pauseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(
          title: 'G A M E   P A U S E D',
          primaryText: 'Resume',
          primaryPressed: () => _manager.resumeGame(),
        );
      },
    );
  }

  void _stageClearDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(
            title: 'Congratulation!', primaryText: 'Next Stage', primaryPressed: () => _manager.nextStage());
      },
    );
  }

  void _gameendDialog({bool isRecall = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameEndDialog(isRecall: isRecall);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('GameplayTetrisPanel builded');

    return ShakeWidget(
      key: shakeKey,
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: Builder(builder: (context) {
          final showGridLine = context.select((AppSettings settings) => settings.showGridLine);
          final showShadowBlock = context.select((AppSettings settings) => settings.showShadowBlock);
          return Container(
            color: showGridLine ? AppStyle.bgColor : AppStyle.bgColorAccent,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Builder(builder: (context) {
                final manager = context.watch<GamePlayManager>();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: kTetrisMatrixWidth * kTetrisMatrixHeight,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kTetrisMatrixWidth,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int gridX = index % kTetrisMatrixWidth;
                    int gridY = index ~/ kTetrisMatrixWidth;

                    TTBlockID? blockId = manager.getBlockId(gridX, gridY);
                    TTBlockStatus blockStatus = manager.getBlockStatus(gridX, gridY);

                    // shadow 블록 미표시
                    if (blockStatus == TTBlockStatus.shadow && !showShadowBlock) {
                      return Container(
                        color: AppStyle.bgColorAccent,
                      );
                    }

                    if (blockId == null || (_manager.hideCompletedRow && blockStatus == TTBlockStatus.completed)) {
                      return Container(
                        color: AppStyle.bgColorAccent,
                      );
                    }

                    return Container(
                      color: AppStyle.bgColorAccent,
                      child: TTTile(blockId: blockId, status: blockStatus),
                    );
                  },
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
