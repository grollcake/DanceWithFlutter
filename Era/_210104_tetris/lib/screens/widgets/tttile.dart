import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/models/enums.dart';

class TTTile extends StatelessWidget {
  const TTTile({Key? key, required this.blockId, required this.status}) : super(key: key);
  final TTBlockID blockId;
  final TTBlockStatus status;
  static const typeCount = 3;
  static int typeId = 0;

  @override
  Widget build(BuildContext context) {
    Color color = AppStyle.tileColor(blockId);
    if (status == TTBlockStatus.shadow) {
      color = color.withOpacity(0.2);
    }
    return _getShape(typeId, color);
  }

  static Widget _getShape(int id, [Color color = AppStyle.accentColor]) {
    switch (id) {
      case 0:
        return Container(
          decoration: BoxDecoration(
            color: color,
          ),
        );
      case 1:
        return Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      case 2:
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 2.0,
              color: Colors.grey.shade800, // todo 여기 색상을 color와 연관있는 것으로 바꿔야 해
            ),
          ),
        );
    }
    return SizedBox();
  }

  static Widget shapeType(int index) {
    return _getShape(index);
  }
}
