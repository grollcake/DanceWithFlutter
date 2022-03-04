import 'package:flutter/material.dart';
import 'package:sliding_puzzle/settings/constants.dart';

class GameController with ChangeNotifier {
  List<int> _piecesPositions = [];
  List<String> _piecesContents = [];
  final int _piecesCount = kPuzzleDimension * kPuzzleDimension - 1;

  GameController() {
    init();
  }

  void init() {
    _piecesPositions = List.generate(_piecesCount, (index) => index);
    _piecesContents = List.generate(_piecesCount, (index) => 'PIECE-$index');
  }

  void shuffle() {
    _piecesPositions.shuffle();
  }

  int get puzzleDimension => kPuzzleDimension;

  int get piecesCount => _piecesCount;

  /// 조각 위치 반환
  int getPiecePosition(int pieceId) => _piecesPositions[pieceId];

  /// 조각 이름 반환
  String getPieceContent(int pieceId) => _piecesContents[pieceId];

  /// 상하좌우에 빈 칸이 있다면 이동 가능한 것이다
  bool isMovable(int pieceId) => _getMovablePosition(pieceId) != null;

  /// 조각 이동: 이동 후에는 새로운 위치를 반환한다.
  int? movePiece(int pieceId) {
    int? newPosition = _getMovablePosition(pieceId);
    if (newPosition != null) {
      _piecesPositions[pieceId] = newPosition;
    }
    return newPosition;
  }

  /// 인접한 이동 가능한 블록위치 반환
  int? _getMovablePosition(int pieceId) {
    int currentPosition = _piecesPositions[pieceId];

    // 1. 상 확인: 위 블록이 비어있는지 확인
    int upPosition = currentPosition - kPuzzleDimension;
    if (upPosition >= 0 && !_piecesPositions.contains(upPosition)) return upPosition;

    // 2. 하 확인: 아래 블록이 비어있는지 확인
    int downPosition = currentPosition + kPuzzleDimension;
    if (downPosition < kPuzzleDimension * kPuzzleDimension && !_piecesPositions.contains(downPosition)) return downPosition;

    // 3. 좌 확인: 왼쪽 블록이 비어있는지 확인
    if (currentPosition % 3 != 0) {
      int leftPosition = currentPosition - 1;
      if (!_piecesPositions.contains(leftPosition)) return leftPosition;
    }

    // 4. 우 확인: 오른쪽 블록이 비어있는지 확인
    if ((currentPosition + 1) % 3 != 0) {
      int rightPosition = currentPosition + 1;
      if (!_piecesPositions.contains(rightPosition)) return rightPosition;
    }

    // 5. 여기까지 왔다면 움직일 수 있는 위치는 없는 것이다.
    return null;
  }
}
