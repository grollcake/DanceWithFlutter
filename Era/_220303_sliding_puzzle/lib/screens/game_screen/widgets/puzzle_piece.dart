import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/settings/app_style.dart';
import 'package:sliding_puzzle/settings/constants.dart';

class PuzzlePiece extends StatelessWidget {
  PuzzlePiece({
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
    final gameStatus = context.read<GameController>().gameStatus;
    Duration duration = Duration(milliseconds: gameStatus == GameStatus.starting ? 1800 : 500);

    return AnimatedPositioned(
      left: pieceOffset.dx,
      top: pieceOffset.dy,
      duration: duration,
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
            child:
                Text(content, style: TextStyle(fontSize: 20, color: AppStyle.textColor, fontWeight: FontWeight.bold)),
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
