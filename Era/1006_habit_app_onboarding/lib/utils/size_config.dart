import 'package:flutter/material.dart';

class SizeConfig {
  final BuildContext context;
  static Size? size;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockH;
  static double? blockW;

  SizeConfig({required this.context});

  void init() {
    size = MediaQuery.of(context).size;
    screenHeight = size!.height;
    screenWidth = size!.width;
    blockH = screenHeight! / 100;
    blockW = screenWidth! / 100;
  }
}
