import 'dart:async';

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

  // 매초 변경시마다 notifyListeners()를 호출할 필요가 없도록 하기 위해 stream을 사용한다.
  final StreamController _timerStreamController = StreamController<String>();

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

  Stream get elapsedTimeStream => _timerStreamController.stream;

  /// 게임리셋
  void resetGame() async {
    init();
    setGameStatus(GameStatus.ready);
    notifyListeners();
    _stopTimer(reset: true);
    notifyListeners();
  }

  /// 게임시작
  void startGame() async {
    debugPrint('Game started');
    init();
    shuffle();
    setGameStatus(GameStatus.playing);
    _startTimer();
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
  // bool isMovable(int pieceId) => _getMovablePosition(pieceId) != null;

  /// 조각 이동: 이동 후에는 새로운 위치를 반환한다.
  int? movePiece(int pieceId) {
    int? emptyPosition;
    int? moveSteps;

    emptyPosition = _findEmptyPosition(pieceId, 'UP');
    if (emptyPosition != null) {
      moveSteps = _puzzleDimension * -1;
    } else {
      emptyPosition = _findEmptyPosition(pieceId, 'DOWN');
      if (emptyPosition != null) {
        moveSteps = _puzzleDimension;
      } else {
        emptyPosition = _findEmptyPosition(pieceId, 'LEFT');
        if (emptyPosition != null) {
          moveSteps = -1;
        } else {
          emptyPosition = _findEmptyPosition(pieceId, 'RIGHT');
          if (emptyPosition != null) {
            moveSteps = 1;
          }
        }
      }
    }

    List<int> pieceIds = [];
    if (emptyPosition != null && moveSteps != null) {
      for (int position = _piecesPositions[pieceId]; position != emptyPosition; position += moveSteps) {
        pieceIds.add(_piecesPositions.indexWhere((element) => element == position));
      }
      for (int i = 0; i < pieceIds.length; i++) {
        _piecesPositions[pieceIds[i]] += moveSteps;
      }

      if (_completeCheck()) {
        _stopTimer(reset: false);
        debugPrint('Completed');
      }
      notifyListeners();
    }

    return emptyPosition;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////
  /// 내부 전용 함수
  //////////////////////////////////////////////////////////////////////////////////////////////////

  /// 상하좌우 방향으로 빈셀 위치 찾기
  int? _findEmptyPosition(int pieceId, String direction) {
    int currentPosition = _piecesPositions[pieceId];

    switch (direction) {
      case 'UP':
        int checkPosition = currentPosition - _puzzleDimension;
        while (checkPosition >= 0) {
          // 체크셀의 위치(Position)가 사용중이 아니라면 찾던 빈셀이다.
          if (!_piecesPositions.contains(checkPosition)) {
            return checkPosition;
          }
          checkPosition -= _puzzleDimension;
        }
        break;

      case 'DOWN':
        int checkPosition = currentPosition + _puzzleDimension;
        while (checkPosition < _puzzleDimension * _puzzleDimension) {
          // 체크셀의 위치(Position)가 사용중이 아니라면 찾던 빈셀이다.
          if (!_piecesPositions.contains(checkPosition)) {
            return checkPosition;
          }
          checkPosition += _puzzleDimension;
        }
        break;

      case 'LEFT':
        int currentRow = currentPosition ~/ _puzzleDimension;
        int checkPosition = currentPosition - 1;
        // 줄 번호가 같아야 한다.
        while (checkPosition >= 0 && (checkPosition ~/ _puzzleDimension) == currentRow) {
          // 체크셀의 위치(Position)가 사용중이 아니라면 찾던 빈셀이다.
          if (!_piecesPositions.contains(checkPosition)) {
            return checkPosition;
          }
          checkPosition -= 1;
        }
        break;

      case 'RIGHT':
        int currentRow = currentPosition ~/ _puzzleDimension;
        int checkPosition = currentPosition + 1;
        // 줄 번호가 같아야 한다.
        while ((checkPosition ~/ _puzzleDimension) == currentRow) {
          // 체크셀의 위치(Position)가 사용중이 아니라면 찾던 빈셀이다.
          if (!_piecesPositions.contains(checkPosition)) {
            return checkPosition;
          }
          checkPosition += 1;
        }
        break;
    }

    // 여기까지 왔다면 상하좌우 방향으로 빈 셀이 없는 것이다.
    return null;
  }

  /// 인접한 이동 가능한 위치번호 반환
  int? _getMovablePosition(int pieceId) {
    int currentPosition = _piecesPositions[pieceId];

    // 1. 상 확인: 위 블록이 비어있는지 확인
    int upPosition = currentPosition - _puzzleDimension;
    if (upPosition >= 0 && !_piecesPositions.contains(upPosition)) return upPosition;

    // 2. 하 확인: 아래 블록이 비어있는지 확인
    int downPosition = currentPosition + _puzzleDimension;
    if (downPosition < _puzzleDimension * _puzzleDimension && !_piecesPositions.contains(downPosition)) {
      return downPosition;
    }

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

  /// 시간 문자열 생성: output => 03:05
  String _formattedTime() {
    if (_stopwatch == null) {
      return '00:00';
    } else {
      return _stopwatch!.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
          ':' +
          _stopwatch!.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    }
  }

  /// 타이머 시작
  void _startTimer() {
    _stopwatch = Stopwatch()..start();
    _timerStreamController.sink.add(_formattedTime());

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_stopwatch?.isRunning ?? false) {
        _timerStreamController.sink.add(_formattedTime());
      } else {
        timer.cancel();
      }
    });
  }

  /// 타이머 종료
  void _stopTimer({required bool reset}) {
    _stopwatch?.stop();
    if (reset) _stopwatch?.reset();
    _timerStreamController.sink.add(_formattedTime());
  }
}
