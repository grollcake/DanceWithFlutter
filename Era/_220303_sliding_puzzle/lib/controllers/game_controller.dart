import 'package:flutter/material.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/settings/constants.dart';

class GameController with ChangeNotifier {
  int _puzzleDimension = kPuzzleDimension;
  int _piecesCount = kPuzzleDimension * kPuzzleDimension - 1;
  bool _isCompleted = false;
  List<int> _piecesPositions = [];
  List<String> _piecesContents = [];
  GameStatus _gameStatus = GameStatus.ready;
  Stopwatch? _stopwatch;

  GameController() {
    init();
  }

  void init() {
    _isCompleted = false;
    _piecesPositions = List.generate(_piecesCount, (index) => index);
    _piecesContents = List.generate(_piecesCount, (index) => 'P-$index');
  }

  void shuffle() {
    _piecesPositions.shuffle();
    notifyListeners();
  }

  /// Getters
  int get puzzleDimension => _puzzleDimension;
  int get piecesCount => _piecesCount;
  GameStatus get gameStatus => _gameStatus;
  String get elapsedTime => _formattedTime();

  /// 게임리셋
  void resetGame() async {
    init();
    setGameStatus(GameStatus.ready);
    notifyListeners();
    _stopwatch?.reset();
    notifyListeners();
  }

  /// 게임시작
  void startGame() async {
    debugPrint('Game started');
    init();
    shuffle();
    setGameStatus(GameStatus.playing);
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _stopwatch = Stopwatch()..start();
    notifyListeners();
  }

  /// 게임 상태 변경
  void setGameStatus(GameStatus status) {
    _gameStatus = status;
    notifyListeners();
  }

  /// 게임 레벨 변경
  void setPuzzleDimension(int dimension) {
    _puzzleDimension = dimension;
    _piecesCount = _puzzleDimension * _puzzleDimension - 1;
    init();
    notifyListeners();
  }

  /// 조각 위치 반환
  int getPiecePosition(int pieceId) => _piecesPositions[pieceId];

  /// 조각 이름 반환
  String getPieceContent(int pieceId) => _piecesContents[pieceId];

  /// 이동 가능 확인: 상하좌우에 빈 칸이 있다면 이동 가능한 것이다
  bool isMovable(int pieceId) => _getMovablePosition(pieceId) != null;

  /// 조각 이동: 이동 후에는 새로운 위치를 반환한다.
  int? movePiece(int pieceId) {
    int? newPosition = _getMovablePosition(pieceId);
    if (newPosition != null) {
      _piecesPositions[pieceId] = newPosition;
    }
    notifyListeners();
    return newPosition;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////
  /// 내부 전용 함수
  //////////////////////////////////////////////////////////////////////////////////////////////////

  /// 인접한 이동 가능한 블록위치 반환
  int? _getMovablePosition(int pieceId) {
    int currentPosition = _piecesPositions[pieceId];

    // 1. 상 확인: 위 블록이 비어있는지 확인
    int upPosition = currentPosition - _puzzleDimension;
    if (upPosition >= 0 && !_piecesPositions.contains(upPosition)) return upPosition;

    // 2. 하 확인: 아래 블록이 비어있는지 확인
    int downPosition = currentPosition + _puzzleDimension;
    if (downPosition < _puzzleDimension * _puzzleDimension && !_piecesPositions.contains(downPosition))
      return downPosition;

    // 3. 좌 확인: 왼쪽 블록이 비어있는지 확인
    if (currentPosition % _puzzleDimension != 0) {
      int leftPosition = currentPosition - 1;
      if (!_piecesPositions.contains(leftPosition)) return leftPosition;
    }

    // 4. 우 확인: 오른쪽 블록이 비어있는지 확인
    if ((currentPosition + 1) % _puzzleDimension != 0) {
      int rightPosition = currentPosition + 1;
      if (!_piecesPositions.contains(rightPosition)) return rightPosition;
    }

    // 5. 여기까지 왔다면 움직일 수 있는 위치는 없는 것이다.
    return null;
  }

  /// 완성 여부 반환
  bool _completeCheck() {
    // 모든 조각의 id가 위치번호와 일치하면 완성된 것이다.
    for (int pieceId = 0; pieceId < _piecesPositions.length; pieceId++) {
      if (_piecesPositions[pieceId] != pieceId) {
        _isCompleted = false;
        notifyListeners();
        return false;
      }
    }
    _isCompleted = true;
    notifyListeners();
    return true;
  }

  String _formattedTime() {
    if (_stopwatch == null) {
      return '00:00';
    } else {
      return _stopwatch!.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
          ':' +
          _stopwatch!.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    }
  }
}
