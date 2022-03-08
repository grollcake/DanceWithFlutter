import 'package:flutter/material.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/settings/app_style.dart';
import 'package:sliding_puzzle/settings/constants.dart';
import 'package:provider/provider.dart';

class PuzzleSection extends StatefulWidget {
  const PuzzleSection({Key? key}) : super(key: key);

  @override
  State<PuzzleSection> createState() => _PuzzleSectionState();
}

class _PuzzleSectionState extends State<PuzzleSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppStyle.bgColor,
          // border: Border.all(
          //   color: Colors.black,
          //   width: 2,
          // ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final gameController = context.watch<GameController>();

            double pieceWidth = (constraints.maxWidth - (gameController.puzzleDimension - 1) * kPuzzlePieceSpace) /
                gameController.puzzleDimension;
            double pieceHeight = (constraints.maxHeight - (gameController.puzzleDimension - 1) * kPuzzlePieceSpace) /
                gameController.puzzleDimension;

            return Stack(
              children: List.generate(gameController.piecesCount, (index) {
                int positionNo = gameController.getPiecePosition(index);
                String pieceName = gameController.getPieceContent(index);

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
      ),
    );
  }

  /// 조각을 탭하면 이동처리
  _movePiece(int pieceId) {
    final gameController = context.read<GameController>();
    int oldPosition = gameController.getPiecePosition(pieceId);
    int? newPosition = gameController.movePiece(pieceId);
    if (newPosition != null) {
      debugPrint('PieceMoved: $oldPosition => $newPosition'); // fixme 여기는 삭제해야 돼
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
    Offset pieceOffset = _calcOffset(context, positionNo);

    return AnimatedPositioned(
      left: pieceOffset.dx,
      top: pieceOffset.dy,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      child: GestureDetector(
        onTap: () => onTap(pieceId),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppStyle.secondaryColor,
            borderRadius: BorderRadius.circular(width * .1),
          ),
          child: Center(
            child: Text(content, style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  /// 조각이 표시될 위치 계산 (x, y)
  Offset _calcOffset(BuildContext context, int position) {
    final gameController = context.read<GameController>();

    return Offset(
      (position % gameController.puzzleDimension) * (width + kPuzzlePieceSpace),
      (position ~/ gameController.puzzleDimension) * (height + kPuzzlePieceSpace),
    );
  }
}
