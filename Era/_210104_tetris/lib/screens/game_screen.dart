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
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: buildTopPanel(),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: buildHoldPanel(),
                    ),
                    Expanded(
                      flex: 5,
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
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          buildNextPanel(),
                          buildStatusPanel(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: buildControlPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTopPanel() {
    String timerText1 = ttBoard.getCurrentElapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
        ':' +
        ttBoard.getCurrentElapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    String timerText2 = ttBoard.getTotalElapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
        ':' +
        ttBoard.getTotalElapsed.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Level:\n${ttBoard.getLevel}', textAlign: TextAlign.center),
          Text('Cleans:\n${ttBoard.getCleans}', textAlign: TextAlign.center),
          Text('Blocks:\n${ttBoard.getBlockCount}', textAlign: TextAlign.center),
          Text('Speed:\n${ttBoard.getSpeed.inMilliseconds}ms', textAlign: TextAlign.center),
          Text('Elapsed:\n$timerText1\n$timerText2', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Hold 패널 Build
  Widget buildHoldPanel() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            color: Colors.pinkAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HOLD', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
              Expanded(
                child: Center(
                  child: MiniBlock(blockID: ttBoard.getHoldId),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 상태표시 화면 Build
  Widget buildNextPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Colors.pinkAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('NEXT', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
              Expanded(
                child: Center(
                  child: MiniBlock(blockID: ttBoard.getNextId),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 상태표시 화면 Build
  Widget buildStatusPanel() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      color: Colors.black54,
      child: Column(
        children: List.generate(
          TTBlockID.values.length,
          (index) => Container(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  TTBlockID.values[index].toString().split('.')[1] +
                      ': ' +
                      ttBoard.getBlockFrequency(TTBlockID.values[index]).toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }

  // 테트리스 화면 Build
  Widget buildTetrisPanel() {
    return ShakeWidget(
      key: shakeKey,
      child: Container(
        padding: EdgeInsets.all(0),
        color: Colors.purpleAccent[800],
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: TTBoard.width,
            crossAxisSpacing: 0.5,
            mainAxisSpacing: 0.5,
          ),
          itemCount: kTetrisMatrixWidth * kTetrisMatrixHeight,
          itemBuilder: (BuildContext context, int index) {
            int gridX = index % kTetrisMatrixWidth;
            int gridY = index ~/ kTetrisMatrixWidth;

            Color color = Colors.deepPurple.shade800;

            TTBlockID? id = ttBoard.getBlockId(gridX, gridY);
            if (id != null) {
              if (_isFlikering && ttBoard.isCompletedTile(gridX, gridY)) {
                color = bgTileColor;
              } else {
                color = getBlockColor(id);

                // Drop될 위치의 미리보기 블록은 흐릿하게 표시
                if (ttBoard.getBlockStatus(gridX, gridY) == TTBlockStatus.preivew) {
                  color = color.withOpacity(0.2);
                }
              }
            }

            return Container(
              margin: EdgeInsets.all(0.5),
              color: color,
              // child: Center(
              //     child: Text(gridX.toString() + ',' + gridY.toString(),
              //         style: TextStyle(fontSize: 10, color: Colors.black54))),
            );
          },
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
