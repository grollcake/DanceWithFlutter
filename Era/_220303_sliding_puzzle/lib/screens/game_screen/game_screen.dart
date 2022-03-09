import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';
import 'package:sliding_puzzle/models/enums.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/completed_bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/playing_bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/ready_bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/puzzle_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/starting_bottom_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/top_section.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/upper_section.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /// 가로가 더 긴 화면에서도 하단 컨텐츠가 잘리지 않도록 크기를 계산한다.
  Size _calcContentsSize(BuildContext context) {
    const double aspectRatio = 1 / 2.3; // 가로/세로 비율
    const double minHorizontalPadding = 40.0;
    const double minVerticalPadding = 40.0;
    final Size screenSize = MediaQuery.of(context).size;

    double contentsWidth = screenSize.width - minHorizontalPadding * 2;
    double contentsHeight = screenSize.height - minVerticalPadding * 2;
    contentsHeight -= MediaQuery.of(context).padding.top; // 모바일 상단 상태바 높이만큼 빼준다.

    if (contentsWidth / aspectRatio > contentsHeight) {
      contentsWidth = contentsHeight * aspectRatio;
    } else {
      contentsHeight = contentsWidth / aspectRatio;
    }

    return Size(contentsWidth, contentsHeight);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('GameScreen() rebuilded');

    Size contentsSize = _calcContentsSize(context);

    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      body: Container(
        width: double.infinity,
        // 상단 상태바 높이만큼 내리고 시작한다.
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        alignment: Alignment.center,
        child: Column(
          children: [
            TopSection(),
            Container(
              width: contentsSize.width,
              height: contentsSize.height,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: UpperSection(),
                  ),
                  Flexible(
                    flex: 2,
                    child: PuzzleSection(),
                  ),
                  Flexible(
                    flex: 1,
                    child: BottomSection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
