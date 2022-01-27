import 'package:flutter/material.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/widgets/tttile.dart';

class AppStyle {
  // 기본 색상 테마
  static const Color accentColor = Colors.yellowAccent;
  static const Color secondaryColor = Colors.pinkAccent;
  static const Color bgColor = Color(0xFF292D3E);
  static const Color bgColorAccent = Color(0xFF1F1E32);
  static const Color bgColorWeak = Color(0xFF3D4667);
  static const Color darkTextColor = Colors.black87;
  static const Color lightTextColor = Colors.white;

  // 배경화면 테마
  static int backgroundImageId = 0;
  static List<String> backgroundImages = [
    'assets/images/bg01.png',
    'assets/images/bg02.jpg',
    'assets/images/bg03.jpg',
    'assets/images/bg04.jpg',
    'assets/images/bg05.jpg',
    'assets/images/bg06.jpg'
  ];

  // 테트리스 블록 색상 테마
  static int colorSetId = 0;
  static List<List<Color>> colorSets = [
    // Color set #1
    [
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.yellow.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.indigo.shade400,
      Colors.purple.shade400
    ],
    [
      Color(0xff8ecae6),
      Color(0xff219ebc),
      Color(0xff126782),
      Color(0xff023047),
      Color(0xffffb703),
      Color(0xfffd9e02),
      Color(0xfffb8500)
    ],
    [
      Color(0xff84e3c8),
      Color(0xffa8e6cf),
      Color(0xffdcedc1),
      Color(0xffffd3b6),
      Color(0xffffaaa5),
      Color(0xffff8b94),
      Color(0xffff7480)
    ],
    [
      Color(0xfff26b21),
      Color(0xfff78e31),
      Color(0xfffbb040),
      Color(0xfffcec52),
      Color(0xffcbdb47),
      Color(0xff99ca3c),
      Color(0xff208b3a)
    ],
    [
      Color(0xfff3eaf9),
      Color(0xfff1e3fc),
      Color(0xffecd6fc),
      Color(0xffe9ccfc),
      Color(0xffe6c1ff),
      Color(0xffe1b7ff),
      Color(0xffdbaaff)
    ],
    [
      Color(0xff264653),
      Color(0xff287271),
      Color(0xff2a9d8f),
      Color(0xff8ab17d),
      Color(0xffe9c46a),
      Color(0xfff4a261),
      Color(0xffe76f51)
    ]
  ];

  // 테트리스 블록 타일의 모양 테마
  // static Widget tileShape = TTTile(blockId: 0);

  // 정보 조회
  static Color tileColor(TTBlockID blockID) => colorSets[colorSetId][blockID.index];
}
