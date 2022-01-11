import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/ttboard.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/widgets/game_dialog.dart';
import 'package:tetris/screens/widgets/preview_block.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int maxColumns = TTBoard.width;
  static const int maxRows = TTBoard.height;
  final Color bgTileColor = Colors.grey.shade700;

  TTBoard ttBoard = TTBoard();
  TTBlockID? _holdBlockId;
  Timer? _timer;
  bool _isFlikering = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showGameStartDialog());
  }

  // 게임 시작
  void _startGame() {
    _holdBlockId = null;
    ttBoard.reset();
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
      builder: (BuildContext context) {
        return GameDialog(title: 'Let\'s play', btnText: 'Start', onPressed: _startGame);
      },
    );
  }

  // 게임종료 Dialog
  void _showGameEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GameDialog(title: 'Game end', btnText: 'Restart', onPressed: _startGame);
      },
    );
  }

  // 블록 자동 이동 타이머 개시
  void _startTimer() {
    if (_timer == null ? false : _timer!.isActive) _timer!.cancel();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
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

  // 블록 홀드
  void _holdBlock() {
    if (_holdBlockId == null) {
      _holdBlockId = ttBoard.blockId;
      _generateNewBlock();
    } else {
      TTBlockID? _tempBlockId = _holdBlockId;
      _holdBlockId = ttBoard.blockId;
      setState(() {
        ttBoard.changeBlock(_tempBlockId!);
      });
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

      await Future.delayed(Duration(milliseconds: 200));
    }

    // 새로운 블록 생성
    _generateNewBlock();
  }

  // 블록 색상 반환
  Color _getTileColor(TTBlockID blockID) {
    if (blockID.index > 6) return Colors.grey.shade200;

    return [
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.yellow.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.indigo.shade400,
      Colors.purple.shade400
    ][blockID.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
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
                      child: buildTetrisPanel(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Center(
                    child: PreviewBlock(blockID: _holdBlockId),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Center(
                    child: PreviewBlock(blockID: ttBoard.nextId),
                  ),
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
      color: Colors.yellow,
    );
  }

  // 테트리스 화면 Build
  Widget buildTetrisPanel() {
    return Container(
      padding: EdgeInsets.all(0),
      color: Colors.purpleAccent[800],
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: TTBoard.width,
          crossAxisSpacing: 0.5,
          mainAxisSpacing: 0.5,
        ),
        itemCount: maxColumns * maxRows,
        itemBuilder: (BuildContext context, int index) {
          int gridX = index % maxColumns;
          int gridY = index ~/ maxColumns;

          Color color = Colors.deepPurple.shade800;

          TTBlockID? id = ttBoard.getBlockId(gridX, gridY);
          if (id != null) {
            if (_isFlikering && ttBoard.isCompletedTile(gridX, gridY)) {
              color = bgTileColor;
            } else {
              color = _getTileColor(id);
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
    );
  }

  // 조작 화면 Build
  Widget buildControlPanel() {
    return Container(
      color: Colors.grey,
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score'),
              Text('${ttBoard.score}',
                  style: TextStyle(fontSize: 22, color: Colors.yellow, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue, shape: CircleBorder()),
            onPressed: () => _movenRotate('LEFT'),
            child: Icon(Icons.arrow_back),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue, shape: CircleBorder()),
            onPressed: () => _movenRotate('ROTATE'),
            child: Icon(Icons.refresh),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue, shape: CircleBorder()),
            onPressed: () => _movenRotate('RIGHT'),
            child: Icon(Icons.arrow_forward),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue, shape: CircleBorder()),
            onPressed: () => _movenRotate('DOWN'),
            child: Icon(Icons.arrow_downward),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.pinkAccent, shape: CircleBorder()),
            onPressed: () => _holdBlock(),
            child: Text('H'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.pinkAccent, shape: CircleBorder()),
            onPressed: () {
              setState(() {
                _timer?.cancel();
                ttBoard.reset();
                _showGameStartDialog();
              });
            },
            child: Text('R'),
          ),
        ],
      ),
    );
  }
}
