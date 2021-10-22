import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_app_onboarding/constants/app_style.dart';
import 'package:habit_app_onboarding/utils/size_config.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig(context: context).init();

    // 안드로이드 상단 상태바 다시 보임
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

    return Scaffold(
      body: Center(
        child: Text(
          'Amki coding by Era, \n2021.10.07',
          style: AppStyle.titleText,
        ),
      ),
    );
  }
}
