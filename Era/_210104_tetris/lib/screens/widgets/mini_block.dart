import 'package:flutter/material.dart';
import 'package:tetris/managers/ttblock.dart';
import 'package:tetris/models/enums.dart';

class MiniBlock extends StatelessWidget {
  const MiniBlock({Key? key, this.blockID}) : super(key: key);

  final TTBlockID? blockID;
  static const double blockSize = 10.0;

  @override
  Widget build(BuildContext context) {
    if (blockID == null) return SizedBox();

    List<List<int>> block = _getBlockShape(blockID!);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        block.length,
            (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              block[row].length,
                  (col) => Container(
                margin: EdgeInsets.all(0.5),
                width: blockSize,
                height: blockSize,
                decoration: BoxDecoration(
                  color: block[row][col] == 1 ? Colors.white : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<List<int>> _getBlockShape(TTBlockID id) {
    switch (id) {
      case TTBlockID.I:
        return [
          [1],
          [1],
          [1],
          [1]
        ];
      case TTBlockID.J:
        return [
          [0, 1],
          [0, 1],
          [1, 1],
        ];
        break;
      case TTBlockID.L:
        return [
          [1, 0],
          [1, 0],
          [1, 1],
        ];
      case TTBlockID.O:
        return [
          [1, 1],
          [1, 1]
        ];

      case TTBlockID.S:
        return [
          [0, 1, 1],
          [1, 1, 0]
        ];

      case TTBlockID.T:
        return [
          [1, 1, 1],
          [0, 1, 0]
        ];

      case TTBlockID.Z:
        return [
          [1, 1, 0],
          [0, 1, 1]
        ];
    }
  }
}
