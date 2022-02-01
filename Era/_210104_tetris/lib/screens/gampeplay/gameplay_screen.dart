import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/constants.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/ttboard.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/modules/shaker_widget.dart';
import 'package:tetris/modules/sound_player.dart';
import 'package:tetris/modules/swipe_controller.dart';
import 'package:tetris/screens/settings/settings_screen.dart';
import 'package:tetris/screens/widgets/game_dialog.dart';
import 'package:tetris/screens/widgets/mini_block.dart';
import 'package:tetris/screens/widgets/tttile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Color bgTileColor = Colors.grey.shade700;

  TTBoard ttBoard = TTBoard();
  PausableTimer? _timer;
  bool _isFlikering = false;
  bool _isPaused = false;

  final _soundPlayer = SoundPlayer();

  GlobalKey<ShakeWidgetState> shakeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _soundPlayer.init();
    Future.delayed(Duration(milliseconds: 1000), () => _startGame(reset: true));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 게임 시작
  void _startGame({bool reset = false}) {
    if (reset) {
      ttBoard.reset();
    } else {
      ttBoard.levelUp();
    }
    _generateNewBlock();
  }

  // 새로운 블록 생성
  void _generateNewBlock() {
    _timer?.cancel();
    setState(() {
      if (!ttBoard.newBlock()) {
        _showGameEndDialog();
      } else {
        _startTimer();
      }
    });
  }

  // 블록 자동 이동 타이머 개시
  void _startTimer() {
    _timer?.cancel();
    _timer = PausableTimer(ttBoard.getSpeed, () {
      bool result = ttBoard.moveDown();

      // 이동에 성공하면 화면에 반영하고 탈출
      if (result) {
        setState(() {});
        _timer!
          ..reset()
          ..start();
        return;
      } else {
        _fixingBlockPosition();
      }
    })
      ..start();
  }

  // 다음 레벨 이동
  void _showNextLevelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(title: 'Congratulation!', btnText: 'Next level', onPressed: () => _startGame());
      },
    );
  }

  // 게임종료 Dialog
  void _showGameEndDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(title: 'G A M E  E N D', btnText: 'Restart', onPressed: () => _startGame(reset: true));
      },
    );
  }

  // 블록 이동
  bool _movenRotate(String direction) {
    if (ttBoard.getCurrentId == null) return false;
    bool isChanged = false;
    switch (direction) {
      case 'LEFT':
        isChanged = ttBoard.moveLeft();
        break;
      case 'RIGHT':
        isChanged = ttBoard.moveRight();
        break;
      case 'DOWN':
        isChanged = ttBoard.moveDown();
        break;
      case 'ROTATE':
        isChanged = ttBoard.rotate();
        if (isChanged) {
          _soundPlayer.rotateSound();
        }
        break;
    }
    if (isChanged) {
      setState(() {});
    }
    // 아래로 이동하는데 실패했다면 현위치에 블록 확정
    else if (direction == 'DOWN' && !isChanged) {
      _fixingBlockPosition();
    }
    return isChanged;
  }

  // 블록 떨어뜨리기
  void _dropBlock() {
    if (ttBoard.dropBlock()) {
      _soundPlayer.dropSound();
      shakeKey.currentState!.shake();
      _fixingBlockPosition();
    }
  }

  // 블록 홀드
  void _holdBlock() {
    if (ttBoard.holdBlock()) {
      setState(() {});
    }
  }

  // 블록 위치 확정
  void _fixingBlockPosition() async {
    _timer?.cancel();
    setState(() {
      ttBoard.fixBlock();
    });

    // 완성된 줄이 있는 경우, 깜빡이다가 지우기
    if (ttBoard.hasCompleteRow()) {
      // 줄 삭제전 깜빡임 이벤트 보여주기
      for (int i = 0; i < 4; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {
          _isFlikering = !_isFlikering;
        });
      }

      // 줄 삭제
      setState(() {
        int tileCnt = ttBoard.clearing();
        print(tileCnt);
      });
    }

    await Future.delayed(ttBoard.getSpeed);

    if (ttBoard.getCleans >= kCleansForLevel) {
      // 다음 레벨로 이동
      _showNextLevelDialog();
    } else {
      // 새로운 블록 생성
      _generateNewBlock();
    }
  }

  // 일시정지,재개 처리
  void _pauseControll(bool isPausing) {
    // 일시정지 처리
    if (isPausing) {
      // 블록 자동이동 timer 일시정지
      _timer?.pause();
      // ttboard의 플레이타임 타이머 일시정지
      ttBoard.pauseGame();
      setState(() {
        _isPaused = true;
      });
    }
    // 게임 재개 처리
    else {
      _isPaused = false;
      // 블록 자동이동 타이머 재개
      _timer?.start();
      // ttboard의 플레이타임 타이머 재개
      ttBoard.resumeGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back button disabled');
        return false;
      },
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  // 메인 게임화면 레이아웃
  Widget buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppSettings.backgroundImages[AppSettings.backgroundImageId]), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Spacer(),
          // 상단 상태 패널
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            height: 70,
            // width: double.infinity,
            // color: Colors.blueGrey,
            child: buildTopPanel(),
          ),
          SizedBox(height: 6),
          // 메인 게임 패널
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 60),
              Expanded(
                child: SwipeController(
                  child: buildTetrisPanel(),
                  onTap: () => _movenRotate('ROTATE'),
                  onSwipeLeft: (int steps) {
                    for (int i = 0; i < steps; i++) {
                      _movenRotate('LEFT');
                    }
                  },
                  onSwipeRight: (int steps) {
                    for (int i = 0; i < steps; i++) {
                      _movenRotate('RIGHT');
                    }
                  },
                  onSwipeUp: () => _holdBlock(),
                  onSwipeDown: (int steps) {
                    for (int i = 0; i < steps; i++) {
                      _movenRotate('DOWN');
                    }
                  },
                  onSwipeDrop: () => _dropBlock(),
                ),
              ),
              SizedBox(
                width: 60,
                child: buildPauseControll(),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  // 투명 AppBar Build
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () async {
            // 타이머들 일시 정지
            _pauseControll(true);

            // 일시정지 다이얼로그 노출
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SettingsScreen();
              },
            );
            setState(() {});
            _pauseControll(false);
          },
          icon: Icon(
            FontAwesomeIcons.bars,
            size: 18,
            color: AppStyle.lightTextColor,
          ),
        ),
      ],
    );
  }

  // 상태 화면 Build
  Widget buildTopPanel() {
    String timerText = ttBoard.getTotalElapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
        ':' +
        ttBoard.getTotalElapsed.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PreviewPanel(title: 'HOLD', blockId: ttBoard.getHoldId),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Score', style: TextStyle(fontSize: 12, color: AppStyle.lightTextColor)),
                      Text(ttBoard.getScore.toString(),
                          style: TextStyle(fontSize: 16, color: AppStyle.accentColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                      child: Text(ttBoard.getLevel.toString(),
                          style: TextStyle(fontSize: 40, color: AppStyle.accentColor, fontWeight: FontWeight.bold))),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Time', style: TextStyle(fontSize: 12, color: AppStyle.lightTextColor)),
                      Text(timerText,
                          style: TextStyle(fontSize: 16, color: AppStyle.accentColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        PreviewPanel(title: 'NEXT', blockId: ttBoard.getNextId),
      ],
    );
  }

  // 테트리스 화면 Build
  Widget buildTetrisPanel() {
    return ShakeWidget(
      key: shakeKey,
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: Container(
          color: AppSettings.showGridLine ? AppStyle.bgColor : AppStyle.bgColorAccent,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: kTetrisMatrixWidth * kTetrisMatrixHeight,
              // itemCount: kTetrisMatrixWidth,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kTetrisMatrixWidth,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                int gridX = index % kTetrisMatrixWidth;
                int gridY = index ~/ kTetrisMatrixWidth;

                TTBlockID? blockId = ttBoard.getBlockId(gridX, gridY);
                TTBlockStatus blockStatus = ttBoard.getBlockStatus(gridX, gridY);

                // shadow 블록 미표시
                if (blockStatus == TTBlockStatus.shadow && !AppSettings.showShadowBlock) {
                  return Container(
                    color: AppStyle.bgColorAccent,
                  );
                }

                if (blockId == null || (_isFlikering && blockStatus == TTBlockStatus.completed)) {
                  return Container(
                    color: AppStyle.bgColorAccent,
                  );
                }

                return Container(
                  color: AppStyle.bgColorAccent,
                  child: TTTile(blockId: blockId, status: blockStatus),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // 일시정지 아이콘 Build
  Widget buildPauseControll() {
    return IconButton(
      icon: Icon(
        _isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
        color: AppStyle.lightTextColor,
        size: 16,
      ),
      onPressed: () {
        // 타이머들 일시 정지
        _pauseControll(true);

        // 일시정지 다이얼로그 노출
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return GameDialog(title: 'P A U S E D', btnText: 'Resume', onPressed: () => _pauseControll(false));
          },
        );
      },
    );
  }
}

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({
    Key? key,
    required this.blockId,
    required this.title,
  }) : super(key: key);

  final String title;
  final TTBlockID? blockId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: AppStyle.secondaryColor.withOpacity(.2),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
          Expanded(child: MiniBlock(blockID: blockId, size: 10, color: Colors.white)),
        ],
      ),
    );
  }
}
