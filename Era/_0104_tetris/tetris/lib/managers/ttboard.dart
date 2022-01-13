import 'package:tetris/models/enums.dart';
import 'package:tetris/managers/ttblock.dart';

class TTBoard {
  static const int width = 10;
  static const int height = 20;

  // 게임판 (width x height)
  List<List<TTBlockID?>> _boardCoords =
      List.generate(width, (idx) => List.filled(height, null, growable: false), growable: false);

  TTBlock? _block;
  TTBlock? _next;
  TTBlockID? _holdId;
  bool _holdUsed = false;
  int? _blockX;
  int? _blockY;
  int _score = 0;
  List<int> _frequency = List.filled(TTBlockID.values.length, 0);

  TTBoard() {
    reset();
    _makeTestBlocks();
  }

  // Getter
  TTBlockID? get blockId => _block?.id;
  TTBlockID? get nextId => _next?.id;
  TTBlockID? get holdId => _holdId;

  // get block => _block;
  int? get blockX => _blockX;

  int? get blockY => _blockY;

  int get score => _score;

  ////////////////////////////////////////////////////////////////////
  // 초기화 및 블록 생성
  ////////////////////////////////////////////////////////////////////
  // 화면을 모두 Reset
  void reset() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        _boardCoords[x][y] = null;
      }
    }
    _block = null;
    _next = null;
    _holdId = null;
    _holdUsed = false;
    _blockX = 0;
    _blockY = 0;
    _score = 0;
    _frequency = List.filled(TTBlockID.values.length, 0);

    _makeTestBlocks();
  }

  // 테스트 블록 생성
  void _makeTestBlocks() {
    // 초기 블록 생성
    for (int i = 0; i < width; i++) {
      if (i == 6) continue;
      _boardCoords[i][17] = TTBlockID.S;
      _boardCoords[i][18] = TTBlockID.S;
    }
  }

  // 블록 생성
  bool newBlock([TTBlockID? blockId]) {
    _blockX = width ~/ 2;
    _blockY = 0;
    _block = _next ?? TTBlock(blockId);

    // 같은 블록이 연속으로 생성되면 한번 더 재생성 시도한다.
    for (int i = 0; i < 2; i++) {
      _next = TTBlock();
      if (_next!.id != _block!.id) break;
    }

    _frequency[_block!.id.index]++;

    _holdUsed = false;

    // 블록을 생성하자마자 다른 블록과 겹친다면 게임 Over
    if (_isOverlapped(_block!.getCoord(_blockX!, _blockY!))) {
      // 겹치는 부분을 위로 밀어올리고 게임을 종료한다 (기존 블록과 겹쳐서 출력되는 문제 해결위해서임)
      while (_isOverlapped(_block!.getCoord(_blockX!, _blockY!))) {
        _blockY = _blockY! - 1;
      }
      return false;
    } else {
      return true;
    }
  }

  // 블록 변경
  // void changeBlock(TTBlockID blockID) {
  //   _block = TTBlock(blockID);
  // }

  ////////////////////////////////////////////////////////////////////
  // 블록 이동
  ////////////////////////////////////////////////////////////////////
  bool moveLeft() => _moveBlock('LEFT');
  bool moveRight() => _moveBlock('RIGHT');
  bool moveDown() => _moveBlock('DOWN');
  bool rotate() => _moveBlock('ROTATE');

  void dropBlock() {
    while (_moveBlock('DOWN')) {
      continue;
    }
  }

  ////////////////////////////////////////////////////////////////////
  // 블록 보관
  ////////////////////////////////////////////////////////////////////
  bool holdBlock() {
    if (_holdUsed) return false;
    if (_holdId == null) {
      _holdId = _block!.id;
      newBlock();
    } else {
      TTBlockID? _tempBlockId = _holdId;
      _holdId = _block!.id;
      _block = TTBlock(_tempBlockId!);
    }
    _holdUsed = true;
    return true;
  }

  ////////////////////////////////////////////////////////////////////
  // 블록 고정
  ////////////////////////////////////////////////////////////////////
  void fixBlock() {
    if (_block == null) return;
    for (TTCoord coord in _block!.getCoord(_blockX!, _blockY!)) {
      _boardCoords[coord.x][coord.y] = _block!.id;
    }
    _block = null;
    _score += 10;
  }

  ////////////////////////////////////////////////////////////////////
  // 블록 정보 확인
  ////////////////////////////////////////////////////////////////////

  // 요청 위치에 블록이 존재하는지 확인 (고정된 블록, 이동중 블록 모두 확인)
  bool hasBlock(int x, int y) {
    // 고정된 블록부터 확인
    if (_boardCoords[x][y] != null) return true;
    // 이동 중인 블록도 확인
    for (TTCoord coord in _block!.getCoord(blockX!, blockY!)) {
      if (coord.x == x && coord.y == y) return true;
    }
    return false;
  }

  // 요청 위치의 블록 이름을 반환한다 (고정된 블록, 이동중 블록 모두 확인)
  TTBlockID? getBlockId(int x, int y) {
    // 고정된 블록부터 확인
    if (_boardCoords[x][y] != null) return _boardCoords[x][y];

    if (_block == null) return null;

    // 이동 중인 블록도 확인
    for (TTCoord coord in _block!.getCoord(blockX!, blockY!)) {
      if (coord.x == x && coord.y == y) return _block!.id;
    }
    return null;
  }

  // 요청 위치의 블록 상태(고정형,이동중,완성)을 확인
  // TTBlockStatus getBlockStatus(int x, int y) {
  //   if (isCompletedTile(x, y)) return TTBlockStatus.completed;
  //   if (_boardCoords[x][y] != null) return TTBlockStatus.fixed;
  //   if (_block == null) return TTBlockStatus.none;
  //   for (TTCoord coord in _block!.getCoord(blockX!, blockY!)) {
  //     if (coord.x == x && coord.y == y) return TTBlockStatus.float;
  //   }
  //   return TTBlockStatus.none;
  // }

  // 블록 생성 빈도 확인
  int getBlockFrequency(TTBlockID blockID) => _frequency[blockID.index];

  ////////////////////////////////////////////////////////////////////
  // 완성 줄 처리 메서드
  ////////////////////////////////////////////////////////////////////

  // 완성 줄 존재 여부 확인
  bool hasCompleteRow() {
    for (int rowNum = 0; rowNum < height; rowNum++) {
      if (_getRow(rowNum).every((element) => element != null)) return true;
    }
    return false;
  }

  // 타일이 완성 줄에 포함되었는지 확인
  bool isCompletedTile(int x, int y) {
    if (_getRow(y).every((element) => element != null)) {
      return true;
    } else {
      return false;
    }
  }

  // 완성 줄 삭제 후 삭제된 조각 개수 반환
  int clearing() {
    int removedRows = 0;

    // 완성되지 않은 줄만 복사하기 위한 새로운 보드 준비
    List<List<TTBlockID?>> newBoards =
        List.generate(width, (index) => List.filled(height, null, growable: false), growable: false);

    int targetRow = height - 1; // 새로운 보드의 바닥부터 채운다

    // 현재 보드의 바닥부터 시작해서 완성되지 않은 줄만 찾아 새로운 보드로 복사한다
    for (int rowNum = height - 1; rowNum >= 0; rowNum--) {
      if (_getRow(rowNum).any((element) => element == null)) {
        for (int i = 0; i < width; i++) {
          newBoards[i][targetRow] = _boardCoords[i][rowNum];
        }
        targetRow--;
      } else {
        removedRows++;
      }
    }

    // 보드를 새로운 보드로 교체한다.
    _boardCoords = newBoards.map((element) => List<TTBlockID?>.from(element)).toList();

    // 점수 계산: 한 줄당 100점. 2줄 이상이면 한줄당 보너스 10점 추가
    _score += removedRows * 100;
    _score += (removedRows - 1) * 10;

    // 삭제한 조각 개수 반환
    return removedRows;
  }

  ////////////////////////////////////////////////////////////////////
  // 내부 전용 메서드
  ////////////////////////////////////////////////////////////////////

  // 블록 이동 처리
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

    // 2. 보드의 경계를 벗어났는지 확인해
    List<TTCoord> coords = _block!.getCoord(newX, newY);
    if (!_isInsideBoard(coords)) {
      // 왼쪽, 오른쪽, 아래 이동은 경계를 벗어날 수 없음. 즉시 취소.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) {
        return false;
      }
      // 회전 후 보드의 경계를 벗어나는 경우 위치를 조정해준다.
      else if (direction == 'ROTATE') {
        List<int> adjustOffsets = _getAdjustOffset(coords);
        newX += adjustOffsets[0];
        newY += adjustOffsets[1];
        coords = _block!.getCoord(newX, newY);
      }
    }

    // 3. 기존 블록과 겹치는지 확인
    if (_isOverlapped(coords)) {
      // 이동 명령 후 겹치는 것은 즉시 취소한다.
      if (['LEFT', 'RIGHT', 'DOWN'].contains(direction)) return false;

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
    return !blockCoords.every((e) => e.x < 0 || e.y < 0 || _boardCoords[e.x][e.y] == null);
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

  // 한 줄 반환
  List<TTBlockID?> _getRow(int rowNum) {
    return _boardCoords.map((e) => e[rowNum]).toList();
  }
}

main() {}
