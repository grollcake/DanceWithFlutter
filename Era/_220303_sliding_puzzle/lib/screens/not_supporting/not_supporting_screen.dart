import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_puzzle/screens/game_screen/sections/top_section.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class NotSupportingScreen extends StatelessWidget {
  const NotSupportingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppStyle.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Insufficient height',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          Lottie.asset('assets/animations/landscape-to-portrait-view.json'),
        ],
      ),
    );
  }
}