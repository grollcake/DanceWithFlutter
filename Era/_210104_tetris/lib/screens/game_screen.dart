import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/blockColor.dart';
import 'package:tetris/constants/constants.dart';
import 'package:tetris/managers/ttboard.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/modules/shaker_widget.dart';
import 'package:tetris/modules/swipe_controller.dart';
import 'package:tetris/screens/widgets/circle_button.dart';
import 'package:tetris/screens/widgets/game_dialog.dart';
import 'package:tetris/screens/widgets/mini_block.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Color bgTileColor = Colors.grey.shade700;

  TTBoard ttBoard = TTBoard();
  Timer? _timer;
  bool _isFlikering = false;

  GlobalKey<ShakeWidgetState> shakeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () => _startGame(reset: true));
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

  // 게임시작 전 Dialog
  void _showGameStartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(title: 'Let\'s play', btnText: 'Start', onPressed: () => _startGame(reset: true));
      },
    );
  }

  // 다음 레벨 도전
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
        return GameDialog(title: 'Game end', btnText: 'Restart', onPressed: () => _startGame(reset: true));
      },
    );
  }

  // 블록 자동 이동 타이머 개시
  void _startTimer() {
    if (_timer == null ? false : _timer!.isActive) _timer!.cancel();

    _timer = Timer.periodic(ttBoard.getSpeed, (timer) {
      bool result = ttBoard.moveDown();

      // 이동에 성공하면 화면에 반영하고 탈출
      if (result) {
        setState(() {});
        return;
      } else {
        _fixingBlockPosition();
      }
    });
  }

  // 블록 이동
  bool _movenRotate(String direction) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 70),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg01.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            // 상단 상태 패널
            Container(
              height: 70,
              width: double.infinity,
              // color: Colors.blueGrey,
              child: buildTopPanel(),
            ),
            SizedBox(height: 6),
            // 메인 게임 패널
            SwipeController(
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
          ],
        ),
      ),
    );
  }

  Widget buildTopPanel() {
    Color previewBgColor = Colors.pinkAccent.withOpacity(.2);
    String timerText = ttBoard.getTotalElapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
        ':' +
        ttBoard.getTotalElapsed.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: previewBgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('HOLD', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
              Expanded(child: MiniBlock(blockID: ttBoard.getHoldId, size: 10, color: Colors.white)),
            ],
          ),
        ),
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
                      Text('Score', style: TextStyle(fontSize: 12, color: Colors.white)),
                      Text(ttBoard.getScore.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.yellowAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                      child: Text(ttBoard.getLevel.toString(),
                          style: TextStyle(fontSize: 40, color: Colors.yellowAccent, fontWeight: FontWeight.bold))),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Time', style: TextStyle(fontSize: 12, color: Colors.white)),
                      Text(timerText,
                          style: TextStyle(fontSize: 16, color: Colors.yellowAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 50,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: previewBgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('NEXT', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
              Expanded(child: MiniBlock(blockID: ttBoard.getNextId, size: 10, color: Colors.white)),
            ],
          ),
        ),
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
          color: AppStyle.bgColor.withOpacity(0.9),
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
                crossAxisSpacing: 0.5,
                mainAxisSpacing: 0.5,
              ),
              itemBuilder: (BuildContext context, int index) {
                int gridX = index % kTetrisMatrixWidth;
                int gridY = index ~/ kTetrisMatrixWidth;

                Color color = AppStyle.bgColor.withOpacity(0.4);

                TTBlockID? id = ttBoard.getBlockId(gridX, gridY);
                if (id != null) {
                  if (_isFlikering && ttBoard.isCompletedTile(gridX, gridY)) {
                    color = bgTileColor;
                  } else {
                    color = getBlockColor(id);

                    // Drop될 위치의 미리보기 블록은 흐릿하게 표시
                    if (ttBoard.getBlockStatus(gridX, gridY) == TTBlockStatus.preivew) {
                      color = color.withOpacity(0.15);
                    }
                  }
                }

                return Container(
                  margin: EdgeInsets.all(0.5),
                  color: color,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // 조작 화면 Build
  Widget buildControlPanel() {
    return Container(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score'),
              Text('${ttBoard.getScore}',
                  style: TextStyle(fontSize: 22, color: Colors.yellow, fontWeight: FontWeight.bold)),
            ],
          ),
          CircleButton(color: Colors.blue, child: Icon(Icons.arrow_back), onPressed: () => _movenRotate('LEFT')),
          CircleButton(color: Colors.blue, child: Icon(Icons.refresh), onPressed: () => _movenRotate('ROTATE')),
          CircleButton(color: Colors.blue, child: Icon(Icons.arrow_forward), onPressed: () => _movenRotate('RIGHT')),
          CircleButton(color: Colors.blue, child: Icon(Icons.arrow_downward), onPressed: () => _movenRotate('DOWN')),
          CircleButton(color: Colors.pinkAccent, child: Text('D'), onPressed: () => _dropBlock()),
          CircleButton(color: Colors.pinkAccent, child: Text('H'), onPressed: () => _holdBlock()),
        ],
      ),
    );
  }
}
