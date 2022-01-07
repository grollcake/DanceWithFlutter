import 'package:tetris/models/ttblock.dart';

class TTBoard {
  static const int width = 10;
  static const int height = 18;

  // 게임판 (width x height)
  var _boards = List.generate(width, (idx) => List.filled(height, null, growable: false), growable: false);

  TTBlock? _block;
  int? _blockX;
  int? _blockY;

  TTBoard() {
    reset();
  }

  // Getter
  TTBlockID? get blockId => _block?.id;

  // get block => _block;
  int? get blockX => _blockX;

  int? get blockY => _blockY;

  // 화면을 모두 Reset
  void reset() {
    _block = null;
    _blockX = 0;
    _blockY = 0;
  }

  // 블록 생성
  TTBlockID newBlock([TTBlockID? blockId]) {
    _block = TTBlock(blockId ?? TTBlockID.random);
    return _block!.id;
  }

  // 블록 이동
  bool moveLeft() {
    return _moveBlock('LEFT');
  }

  bool _moveBlock(String direction) {
    if (_block == null) return false;

    int newX = _blockX!, newY = _blockY!;

    // 1. 일단은 이동/회전 먼저해
    if (direction == 'LEFT') {
      newX--;
    } else if (direction == 'RIGHT') {
      newX++;
    } else if (direction == 'DOWN') {
      newY++;
    } else if (direction == 'ROTATE') {
      _block!.rotate();
    }

    // 2. 경계를 벗어났는지 확인해
    List<TTCoord> coords = _block!.getCoord(newX, newY);
    if (!_isInsideBoard(coords)) {
      // 왼쪽, 오른쪽, 아래 이동은 경계를 벗어날 수 없음. 즉시 취소.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) {
        return false;
      }
      // 회전은 경계를 벗어날 수도 있기 때문에 위치를 조정값을 반영해준다.
      List<int> adjustOffsets = _getAdjustOffset(coords);
      newX += adjustOffsets[0];
      newY += adjustOffsets[1];
      coords = _block!.getCoord(newX, newY);
    }

    // 3. 기존 블록과 겹치는지 확인
    if (_isOverlapped(coords)) {
      // 이동 명령 후 겹치는 것은 즉시 취소한다.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) return;

      // 회전 후 겹치는 것은, 왼쪽 1칸, 오른쪽 1칸, 왼쪽 2칸, 오른쪽 2칸으로 이동해보면서 자리를 잡을 수 있는지 확인한다.
      bool successAdjust = false;
      for (int offsetX in [-1, 1, -2, 2]) {
        List<TTCoord> coords2 = _block!.getCoord(newX + offsetX, newY);
        if (_isInsideBoard(coords2) && !_isOverlapped(coords2)) {
          newX += offsetX;
          successAdjust = true;
          break;
        }
      }
      if (!successAdjust) {
        _block!.unRotate();
        return false;
      }
    }

    _blockX = newX;
    _blockY = newY;

    return true;
  }

  // 블록이 보드 안에 위치하는지 확인
  bool _isInsideBoard(List<TTCoord> blockCoords) {
    return blockCoords.every((e) => e.x >= 0 && e.x < width && e.y >= 0 && e.y < height);
  }

  // 기존 블록과 겹치는지 확인
  bool _isOverlapped(List<TTCoord> blockCoords) {
    return !blockCoords.every((e) => _boards[e.x][e.y] == TTBlockID.none);
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
      if (check.x >= width) {
        adjustOffsets[0] = (check.x - (width - 1)) * -1;
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
      if (check.y >= height) {
        adjustOffsets[1] = (check.y - (height - 1)) * -1;
      }
    }

    return adjustOffsets;
  }
}

main() {}
