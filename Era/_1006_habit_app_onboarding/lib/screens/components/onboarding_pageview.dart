import 'package:flutter/material.dart';
import 'package:habit_app_onboarding/constants/app_style.dart';
import 'package:habit_app_onboarding/models/onboarding_data.dart';
import 'package:habit_app_onboarding/utils/size_config.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({Key? key, required this.callBack, required this.pageController}) : super(key: key);

  final ValueChanged<int> callBack;
  final PageController pageController;

  @override
  _OnboardingPageViewState createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  double blockH = SizeConfig.blockH!;
  double blockW = SizeConfig.blockW!;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: widget.callBack,
      controller: widget.pageController,
      itemCount: onboardingContents.length,
      itemBuilder: (context, index) {
        final OnboardingContent content = onboardingContents[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: blockH * 5),
              Text(
                content.title,
                textAlign: TextAlign.center,
                style: AppStyle.titleText,
              ),
              SizedBox(height: blockH * 5),
              SizedBox(
                height: blockH * 50,
                child: Image.asset(content.image, fit: BoxFit.contain),
              ),
              SizedBox(height: blockH * 5),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'WE CAN ',
                  style: AppStyle.bodyText,
                  children: [
                    TextSpan(
                      text: 'HELP YOU ',
                      style: TextStyle(color: AppStyle.primaryColor),
                    ),
                    TextSpan(
                      text: 'TO BE A BETTER VERSION OF ',
                    ),
                    TextSpan(
                      text: 'YOURSELF',
                      style: TextStyle(color: AppStyle.primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: blockH * 5),
            ],
          ),
        );
      },
    );
  }
}
