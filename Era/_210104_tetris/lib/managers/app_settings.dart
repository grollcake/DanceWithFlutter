import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/models/enums.dart';

class AppSettings {
  ////////////////////////////////////////////////////////////////////////
  // 배경화면 테마
  ////////////////////////////////////////////////////////////////////////
  static int _backgroundImageId = 0;
  static int get backgroundImageId => _backgroundImageId;

  static set backgroundImageId(int value) {
    _backgroundImageId = value;
    saveSettings();
  }

  static List<String> backgroundImages = [
    'assets/images/bg01.png',
    'assets/images/bg02.jpg',
    'assets/images/bg03.jpg',
    'assets/images/bg04.jpg',
    'assets/images/bg05.jpg',
    'assets/images/bg06.jpg'
  ];

  ////////////////////////////////////////////////////////////////////////
  // 테트리스 블록 색상 테마
  ////////////////////////////////////////////////////////////////////////
  static int _colorSetId = 0;

  static int get colorSetId => _colorSetId;
  static set colorSetId(int value) {
    _colorSetId = value;
    saveSettings();
  }

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

  // 정보 조회
  static Color tileColor(TTBlockID blockID) => colorSets[_colorSetId][blockID.index];

  ////////////////////////////////////////////////////////////////////////
  // 테트리스 블록 타일의 모양 테마
  ////////////////////////////////////////////////////////////////////////
  static int _tileTypeId = 0;

  static int get tileTypeId => _tileTypeId;
  static set tileTypeId(int value) {
    _tileTypeId = value;
    saveSettings();
  }

  ////////////////////////////////////////////////////////////////////////
  // 사용자 정보
  ////////////////////////////////////////////////////////////////////////
  static String? _userId;
  static String? get userId => _userId;
  static set userId(String? id) {
    _userId = id;
    saveSettings();
  }

  static String? _username;
  static String? get username => _username;
  static set username(String? name) {
    _username = name;
    saveSettings();
  }

  ////////////////////////////////////////////////////////////////////////
  // 기타 설정
  ////////////////////////////////////////////////////////////////////////
  static bool _backgroundMusic = true;
  static bool get backgroundMusic => _backgroundMusic;
  static set backgroundMusic(bool value) {
    _backgroundMusic = value;
    saveSettings();
  }

  static bool _showGridLine = true;
  static bool get showGridLine => _showGridLine;
  static set showGridLine(bool value) {
    _showGridLine = value;
    saveSettings();
  }

  static bool _showShadowBlock = true;
  static bool get showShadowBlock => _showShadowBlock;
  static set showShadowBlock(bool value) {
    _showShadowBlock = value;
    saveSettings();
  }

  // 이건 기기설정에 저장하지는 않음
  static int selectedMenuIndex = 0;

  ////////////////////////////////////////////////////////////////////////
  // 설정을 기기에 저장하거나 불러오기
  ////////////////////////////////////////////////////////////////////////
  // 설정을 기기에 저장
  static Future<bool> saveSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> settings = {
      'backgroundImageId': _backgroundImageId,
      'colorSetId': _colorSetId,
      'tileTypeId': _tileTypeId,
      'userId': _userId,
      'username': _username,
      'backgroundMusic': _backgroundMusic,
      'showGridLine': _showGridLine,
      'showShadowBlock': _showShadowBlock,
    };
    String settingsString = jsonEncode(settings);
    bool result = await preferences.setString('settings', settingsString);
    if (result) {
      debugPrint('Setting saved successfully');
      debugPrint(settingsString);
    }
    return result;
  }

  // 설정을 불러오기
  static Future<bool> loadSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? settingsString = preferences.getString('settings');
    if (settingsString != null) {
      debugPrint('Successfully loaded settings');
      debugPrint(settingsString);
      Map<String, dynamic> settings = jsonDecode(settingsString);

      _backgroundImageId = settings['backgroundImageId'] as int;
      _colorSetId = settings['colorSetId'] as int;
      _tileTypeId = settings['tileTypeId'] as int;
      _userId = settings['userId'] as String;
      _username = settings['username'] as String;
      _backgroundMusic = settings['backgroundMusic'] as bool;
      _showGridLine = settings['showGridLine'] as bool;
      _showShadowBlock = settings['showShadowBlock'] as bool;

      return true;
    } else {
      return false;
    }
  }
}
