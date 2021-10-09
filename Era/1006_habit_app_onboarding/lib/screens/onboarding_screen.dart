import 'package:flutter/material.dart';
import 'package:habit_app_onboarding/constants/app_style.dart';
import 'package:habit_app_onboarding/models/onboarding_data.dart';
import 'package:habit_app_onboarding/screens/components/onboarding_pageview.dart';
import 'package:habit_app_onboarding/utils/size_config.dart';
import 'package:habit_app_onboarding/widgets/dot_indicator.dart';
import 'package:habit_app_onboarding/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageNo = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _moveMainScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('ONBOARDING_COMPLETE', true);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context: context).init();
    double blockH = SizeConfig.blockH!;
    double blockW = SizeConfig.blockW!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: OnboardingPageView(
              pageController: pageController,
              callBack: (pageNo) {
                setState(() {
                  _pageNo = pageNo;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: _pageNo != onboardingContents.length - 1
                ? buildBottomNav(context)
                : Center(
                    child: PrimaryButton(
                      text: 'Get Started',
                      onPressed: _moveMainScreen,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: _moveMainScreen,
          child: Text(
            'Skip',
            style: TextStyle(color: AppStyle.secondaryColor),
          ),
        ),
        DotIndicator(pageNo: _pageNo, pageLen: onboardingContents.length),
        TextButton(
          onPressed: () => pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut),
          child: Text(
            'Next',
            style: TextStyle(color: AppStyle.secondaryColor),
          ),
        ),
      ],
    );
  }
}
