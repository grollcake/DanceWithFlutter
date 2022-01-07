import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/managers/ttboard.dart';
import 'package:tetris/models/enums.dart';

void main() => runApp(TetrisApp());

class TetrisApp extends StatelessWidget {
  const TetrisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      home: TetrisHome(),
    );
  }
}

class TetrisHome extends StatefulWidget {
  const TetrisHome({Key? key}) : super(key: key);

  @override
  _TetrisHomeState createState() => _TetrisHomeState();
}

class _TetrisHomeState extends State<TetrisHome> {
  TTBoard ttBoard = TTBoard();
  late Timer _timer;
  static const int MAX_COLUMNS = 10;
  static const int MAX_ROWS = 18;

  @override
  void initState() {
    super.initState();

    ttBoard.newBlock();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!ttBoard.moveDown()) {
        _fixingBlock();
      }
      setState(() {});
    });
  }

  // After block fix
  void _fixingBlock() async {
    setState(() {
      ttBoard.fixBlock();
    });

    if (ttBoard.hasCompleteRow()) {
      _timer.cancel();
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        int tileCnt = ttBoard.clearing();
        print(tileCnt);
      });
    }
    setState(() {
      ttBoard.newBlock();
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
    return isChanged;
  }

  // 블록 색상 반환
  Color _getBlockColor(TTBlockID blockID) {
    if (blockID.index > 6) return Colors.grey.shade200;

    return [
      Colors.red.shade300,
      Colors.orange.shade300,
      Colors.yellow.shade300,
      Colors.green.shade300,
      Colors.blue.shade300,
      Colors.indigo.shade300,
      Colors.purple.shade300
    ][blockID.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(50),
              color: Colors.grey.shade900,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemCount: MAX_COLUMNS * MAX_ROWS,
                itemBuilder: (BuildContext context, int index) {
                  int gridX = index % MAX_COLUMNS;
                  int gridY = index ~/ MAX_COLUMNS;

                  Color color = Colors.grey.shade700;

                  TTBlockID? id = ttBoard.getBlockId(gridX, gridY);

                  if (id != null) {
                    color = _getBlockColor(id);
                  }

                  return Container(
                    margin: EdgeInsets.all(0.2),
                    color: color,
                    // child: Center(child: Text(gridX.toString() + ',' + gridY.toString())),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _movenRotate('LEFT'),
                    child: Text('Left'),
                  ),
                  ElevatedButton(
                    onPressed: () => _movenRotate('ROTATE'),
                    child: Text('Rotate'),
                  ),
                  ElevatedButton(
                    onPressed: () => _movenRotate('RIGHT'),
                    child: Text('Right'),
                  ),
                  ElevatedButton(
                    onPressed: () => _movenRotate('DOWN'),
                    child: Text('Down'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ttBoard.reset();
                        ttBoard.newBlock();
                      });
                    },
                    child: Text('NEW'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
