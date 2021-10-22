import 'package:flutter/material.dart';
import 'package:onboarding_intro2/constants/styles.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, required this.totalPage, required this.currentPage}) : super(key: key);

  final double dotSize = 8;
  final int totalPage;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        totalPage,
        (index) {
          return AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: currentPage == index ? dotSize * 3 : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dotSize),
              color: currentPage == index ? AppStyle.primary : AppStyle.grey,
            ),
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}
