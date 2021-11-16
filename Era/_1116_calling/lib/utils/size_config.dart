import 'package:flutter/material.dart';

class SizeConfig {
  static Size? size;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static Orientation orientation = Orientation.portrait;

  static void init(BuildContext context) {
    size = MediaQuery.of(context).size;
    screenWidth = size!.width;
    screenHeight = size!.height;
    orientation = MediaQuery.of(context).orientation;
  }
}