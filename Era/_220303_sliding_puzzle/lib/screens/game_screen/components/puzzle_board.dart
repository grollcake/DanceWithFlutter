import 'package:flutter/material.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/constants.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late GameController _gameController;

  @override
  void initState() {
    super.initState();

    _gameController = GameController();
    _gameController.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double pieceWidth = (constraints.maxWidth - (kPuzzleDimension - 1) * kPuzzlePieceSpace) / kPuzzleDimension;
          double pieceHeight = (constraints.maxHeight - (kPuzzleDimension - 1) * kPuzzlePieceSpace) / kPuzzleDimension;

          return Stack(
            children: List.generate(_gameController.piecesCount, (index) {
              int positionNo = _gameController.getPiecePosition(index);
              String pieceName = _gameController.getPieceContent(index);

              return Piece(
                pieceId: index,
                positionNo: positionNo,
                width: pieceWidth,
                height: pieceHeight,
                content: pieceName,
                onTap: _movePiece,
              );
            }),
          );
        },
      ),
    );
  }

  /// 조각을 탭하면 이동처리
  _movePiece(int pieceId) {
    if (_gameController.isMovable(pieceId)) {
      int oldPosition = _gameController.getPiecePosition(pieceId);
      int newPosition = _gameController.movePiece(pieceId)!;
      debugPrint('PieceMoved: $oldPosition => $newPosition');
      setState(() {});
    }
  }
}

class Piece extends StatelessWidget {
  Piece({
    Key? key,
    required this.pieceId,
    required this.width,
    required this.height,
    required this.positionNo,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  final int pieceId;
  final int positionNo;
  final String content;
  final double width;
  final double height;
  final Function(int pieceId) onTap;

  @override
  Widget build(BuildContext context) {
    Offset pieceOffset = _calcOffset(positionNo);

    debugPrint('$pieceId: $positionNo - $content');

    return AnimatedPositioned (
      left: pieceOffset.dx,
      top: pieceOffset.dy,
      duration: Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: ()=> onTap(pieceId),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(width * .05),
          ),
          child: Center(
            child: Text(content),
          ),
        ),
      ),
    );
  }

  /// 조각이 표시될 위치 계산 (x, y)
  Offset _calcOffset(int position) {
    return Offset(
      (position % kPuzzleDimension) * (width + kPuzzlePieceSpace),
      (position ~/ kPuzzleDimension) * (height + kPuzzlePieceSpace),
    );
  }
}
