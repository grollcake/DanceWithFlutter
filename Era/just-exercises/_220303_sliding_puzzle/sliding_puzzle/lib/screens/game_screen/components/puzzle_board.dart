import 'package:flutter/material.dart';
import 'package:sliding_puzzle/settings/constants.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  int _piecesCount = 0;

  @override
  void initState() {
    super.initState();
    _piecesCount = kPuzzleDimension * kPuzzleDimension - 1;
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
            children: List.generate(_piecesCount, (index) {
              return Piece(index: index, width: pieceWidth, height: pieceHeight);
            }),
          );
        },
      ),
    );
  }
}

class Piece extends StatelessWidget {
  Piece({Key? key, required this.index, required this.width, required this.height}) : super(key: key);

  final int index;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    double top = (index ~/ kPuzzleDimension) * (height + kPuzzlePieceSpace);
    double left = (index % kPuzzleDimension) * (width + kPuzzlePieceSpace);

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(width * .05),
        ),
        child: Center(
          child: Text(index.toString()),
        ),
      ),
    );
  }
}
