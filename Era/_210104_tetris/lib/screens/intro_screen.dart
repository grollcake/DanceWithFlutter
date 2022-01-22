import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/blockColor.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/game_screen.dart';
import 'package:tetris/screens/widgets/mini_block.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: buildBody(context),
      ),
    );
  }

  // 메인화면 그리기
  Widget buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.4),
          ],
        ),
        // color: Colors.blueGrey.shade800,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          buildLogo(),
          Spacer(flex: 2),
          FadeIn(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 200),
            child: SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: Text(
                  'P L A Y',
                  style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  // 테트리스 블록 3개가 겹쳐진 로고 그리기
  Widget buildLogo() {
    double tileSize = 26;
    return SizedBox(
      width: tileSize * 6,
      height: tileSize * 3,
      child: Stack(
        children: [
          Positioned(
            top: tileSize,
            left: 0,
            child: FadeInLeft(
              duration: Duration(milliseconds: 300),
              from: 40,
              child: MiniBlock(
                blockID: TTBlockID.T,
                size: tileSize,
                color: getBlockColor(TTBlockID.T),
              ),
            ),
          ),
          Positioned(
            top: tileSize,
            left: tileSize * 2,
            child: FadeInDown(
              delay: Duration(milliseconds: 200),
              duration: Duration(milliseconds: 300),
              from: 40,
              child: MiniBlock(
                blockID: TTBlockID.S,
                size: tileSize,
                color: getBlockColor(TTBlockID.S),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: tileSize * 4,
            child: FadeInRight(
              delay: Duration(milliseconds: 400),
              duration: Duration(milliseconds: 300),
              from: 40,
              child: MiniBlock(
                blockID: TTBlockID.J,
                size: tileSize,
                color: getBlockColor(TTBlockID.J),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
