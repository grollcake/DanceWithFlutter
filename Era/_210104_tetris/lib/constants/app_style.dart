import 'package:flutter/material.dart';
import 'package:tetris/models/enums.dart';

class AppStyle {
  // 기본 색상 테마
  static const Color accentColor = Colors.yellowAccent;
  static const Color secondaryColor = Colors.pinkAccent;
  static const Color bgColor = Color(0xFF292D3E);
  static const Color bgColorAccent = Color(0xFF1F1E32);
  static const Color bgColorWeak = Color(0xFF3D4667);
  static const Color darkTextColor = Colors.black87;
  static const Color lightTextColor = Colors.white;

  // 테트리스 블록 색상 테마
  static int colorSetId = 0;
  static List<List<Color>> colorSets = [
    [
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.yellow.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.indigo.shade400,
      Colors.purple.shade400
    ]
  ];

  // 테트리스 블록 타일의 모양 테마
  static int tileShapeId = 0;
  static List<Widget> tileShapes = [
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        shape: BoxShape.circle,
      ),
    ),
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(
          width: 2.0,
          color: Colors.indigo.shade300,
        ),
      ),
    ),
  ];

  // 정보 조회
  static Color blockColor(TTBlockID blockID) => colorSets[colorSetId][blockID.index];
  static Widget get tileShape => tileShapes[tileShapeId];
}
