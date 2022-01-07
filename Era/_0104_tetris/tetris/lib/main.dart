import 'package:flutter/material.dart';
import 'package:tetris/models/ttblock.dart';

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
  static const int MAX_COLUMNS = 10;
  static const int MAX_ROWS = 18;

  var playBoard = List.generate(MAX_COLUMNS, (index) => List.generate(MAX_ROWS, (i) => TTBlockID.none));

  TTBlock? block;
  int blockX = 0;
  int blockY = 0;

  @override
  void initState() {
    super.initState();

    // 초기 블록 생성
    playBoard[0][17] = TTBlockID.I;
    playBoard[1][17] = TTBlockID.I;
    playBoard[2][17] = TTBlockID.I;
    playBoard[3][17] = TTBlockID.I;
    playBoard[4][17] = TTBlockID.I;
    playBoard[8][5] = TTBlockID.I;
    playBoard[8][6] = TTBlockID.I;

    _createBlock();
  }

  // 새로운 블록 생성
  void _createBlock() {
    block = TTBlock(TTBlockID.random);
    blockX = MAX_COLUMNS ~/ 2;
    blockY = 0;
  }

  // 블록 좌우 이동 및 회전 처리
  void _movenRotate(String direction) {
    int newX = blockX, newY = blockY;

    // 1. 일단은 이동/회전 먼저해
    if (direction == 'LEFT') {
      newX--;
    } else if (direction == 'RIGHT') {
      newX++;
    } else if (direction == 'DOWN') {
      newY++;
    } else if (direction == 'ROTATE') {
      block!.rotate();
    }

    // 2. 경계를 벗어났는지 확인해
    List<TTCoord> coords = block!.getCoord(newX, newY);
    if (!_isInsideBoard(coords)) {
      // 왼쪽, 오른쪽, 아래 이동은 경계를 벗어날 수 없음. 즉시 취소.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) {
        return;
      }
      // 회전은 경계를 벗어날 수도 있기 때문에 위치를 조정값을 반영해준다.
      List<int> adjustOffsets = _getAdjustOffset(coords);
      newX += adjustOffsets[0];
      newY += adjustOffsets[1];
      coords = block!.getCoord(newX, newY);
    }

    // 3. 기존 블록과 겹치는지 확인
    if (_isOverlapped(coords)) {
      // 이동 명령 후 겹치는 것은 즉시 취소한다.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) return;

      // 회전 후 겹치는 것은, 왼쪽 1칸, 오른쪽 1칸, 왼쪽 2칸, 오른쪽 2칸으로 이동해보면서 자리를 잡을 수 있는지 확인한다.
      bool successAdjust = false;
      for(int offsetX in [-1, 1, -2, 2]) {
        List<TTCoord> coords2 = block!.getCoord(newX + offsetX, newY);
        if (_isInsideBoard(coords2) && !_isOverlapped(coords2)) {
          newX += offsetX;
          successAdjust = true;
          break;
        }
      }
      if (!successAdjust) {
        block!.unRotate();
        return;
      }
    }

    // 4. 변경 사항 새로 그리기
    setState(() {
      blockX = newX;
      blockY = newY;
    });
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

  // 블록이 테트리스 플레이 보드 안에 위치하는지 확인
  bool _isInsideBoard(List<TTCoord> blockCoords) {
    return blockCoords.every((e) => e.x >= 0 && e.x < MAX_COLUMNS && e.y >= 0 && e.y < MAX_ROWS);
  }

  // 기존 블록과 겹치는지 확인
  bool _isOverlapped(List<TTCoord> blockCoords) {
    return !blockCoords.every((e) => playBoard[e.x][e.y] == TTBlockID.none);
  }

  // 블록 회전 후 경계를 초과한 경우 조정할 [x,y] 값을 반환한다.
  // ① 초과하지 않았다면 [0,0]을 반환한다.
  // ② 왼쪽 경계를 1칸 벗어났다면 [1,0]을, 오른쪽 경계를 1칸 벗어났다면 [-1,0]을 반환한다.
  // ③ 위쪽 경계를 1칸 벗어났다면 [0,1]을, 아래쪽 경계를 1칸 벗어났다면 [0,-1]을 반환한다.
  List<int> _getAdjustOffset(List<TTCoord> coords) {
    List<int> adjustOffsets = [0, 0];

    // 왼쪽 경계를 벗어난 값 찾기 (0 보다 작은 좌표값 찾기)
    TTCoord check = coords.reduce((v, e) => v.x < e.x ? v : e); // 최소 x 좌표 찾기
    if (check.x < 0) {
      // 마이너스 x 값은 양수로 변환해야 한다.
      adjustOffsets[0] = -check.x;
    }
    // 오른쪽 경계를 벗어난 값 찾기 (MAX_COLUMNS을 초과하는 좌표값 찾기)
    else {
      check = coords.reduce((v, e) => v.x > e.x ? v : e); // 최대 x 좌표 찾기
      // 초과한 값을 음수로 변환한다.
      if (check.x >= MAX_COLUMNS) {
        adjustOffsets[0] = (check.x - (MAX_COLUMNS - 1)) * -1;
      }
    }

    // 위쪽 경계를 벗어난 값 찾기 (0보다 작은 좌표값 찾기)
    check = coords.reduce((v, e) => v.y < e.y ? v : e); // 최소 y 좌표 찾기
    if (check.y < 0) {
      adjustOffsets[1] = -check.y;
    }
    // 아래쪽 경계를 벗어난 값 찾기 (MAX_ROWS을 초과하는 좌표값 찾기)
    else {
      check = coords.reduce((v, e) => v.y > e.y ? v : e); // 최대 y 좌표 찾기
      // 초과한 값을 음수로 변환한다.
      if (check.y >= MAX_ROWS) {
        adjustOffsets[1] = (check.y - (MAX_ROWS - 1)) * -1;
      }
    }

    return adjustOffsets;
  }

  @override
  Widget build(BuildContext context) {
    List<TTCoord> blockCoords = block!.getCoord(blockX, blockY);

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 9,
            child: Container(
              color: Colors.amber,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemCount: MAX_COLUMNS * MAX_ROWS,
                itemBuilder: (BuildContext context, int index) {
                  int locX = index % MAX_COLUMNS;
                  int locY = index ~/ MAX_COLUMNS;

                  Color color = Colors.grey.shade200;

                  if (blockCoords.any((e) => e.x == locX && e.y == locY)) {
                    color = _getBlockColor(block!.id);
                  } else {
                    color = _getBlockColor(playBoard[locX][locY]);
                  }

                  return Container(
                    margin: EdgeInsets.all(0.5),
                    color: color,
                    child: Center(child: Text(locX.toString() + ',' + locY.toString())),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.amber.shade200,
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
                        _createBlock();
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
