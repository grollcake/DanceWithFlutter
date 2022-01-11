import 'package:flutter/material.dart';
import 'package:tetris/models/enums.dart';

class PreviewBlock extends StatelessWidget {
  final TTBlockID? blockID;
  final List<List<int>> _blockShapes = [
    [1, 1, 1, 1], // I Block
    [0, 1, 0, 1, 1, 1], // J Block
    [1, 0, 1, 0, 1, 1], // L Block
    [1, 1, 1, 1], // O Block
    [0, 1, 1, 1, 1, 0], // S Block
    [1, 1, 1, 0, 1, 0], // T Block
    [1, 1, 0, 0, 1, 1] // Z Block
  ];
  final List<int> _colWidths = [1, 2, 2, 2, 3, 3, 3];

  PreviewBlock({
    Key? key,
    this.blockID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blockID == null) return SizedBox();

    List<int> blockShape = _blockShapes[blockID!.index];
    int colWidth = _colWidths[blockID!.index];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 블록 타일의 넓이를 일정하게 유지하기 위해서 좌우 여백을 조정한다.
        // I Block은 좌우 여백을 크게 가져가고, S/T/Z 블록은 여백을 없앤다.
        double padding = constraints.maxWidth / 3 * (3 - colWidth);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding / 2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: colWidth,
              mainAxisSpacing: 0.8,
              crossAxisSpacing: 0.8,
            ),
            itemCount: blockShape.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: blockShape[index] == 1 ? Colors.white : Colors.transparent,
              );
            },
          ),
        );
      },
    );
  }
}
