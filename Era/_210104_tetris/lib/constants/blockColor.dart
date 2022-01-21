import 'package:flutter/material.dart';
import 'package:tetris/models/enums.dart';

// 블록 색상 반환
Color getBlockColor(TTBlockID blockID) {
  return [
    Colors.red.shade400,
    Colors.orange.shade400,
    Colors.yellow.shade400,
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.indigo.shade400,
    Colors.purple.shade400
  ][blockID.index];
}
