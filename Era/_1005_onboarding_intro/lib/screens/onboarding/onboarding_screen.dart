import 'package:flutter/material.dart';
import 'package:onboarding_intro2/constants/styles.dart';
import 'package:onboarding_intro2/models/onboarding_data.dart';
import 'package:onboarding_intro2/screens/main/main_screen.dart';
import 'package:onboarding_intro2/screens/onboarding/widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
            icon: Text('Skip', style: TextStyle(fontSize: 16, color: AppStyle.grey)),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(
                () {
                  _pageIndex = index;
                },
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: onboardingDatas.length,
            itemBuilder: (BuildContext context, int index) {
              String title = onboardingDatas[index].title;
              String subTitle = onboardingDatas[index].subTitle;
              String image = onboardingDatas[index].image;
              bool imageFirst = onboardingDatas[index].imageFirst;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageFirst) ...[Image.asset(image, fit: BoxFit.contain), const SizedBox(height: 50)],
                    Text(title,
                        style: TextStyle(fontSize: 26, color: AppStyle.primary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Text(subTitle,
                        style: TextStyle(fontSize: 18, color: AppStyle.grey), textAlign: TextAlign.center),
                    if (!imageFirst) ...[const SizedBox(height: 50), Image.asset(image, fit: BoxFit.contain)],
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 50,
            child: PageIndicator(totalPage: onboardingDatas.length, currentPage: _pageIndex),),
        ],
      ),
    );
  }
}
