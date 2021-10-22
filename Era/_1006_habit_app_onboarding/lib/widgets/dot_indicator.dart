import 'package:flutter/material.dart';
import 'package:habit_app_onboarding/constants/app_style.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required int pageNo,
    required pageLen,
  })  : _pageNo = pageNo,
        _pageLen = pageLen,
        super(key: key);

  final int _pageNo;
  final int _pageLen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pageLen, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _pageNo == index ? 36 : 12,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _pageNo == index ? AppStyle.primaryColor.withOpacity(.5) : AppStyle.secondaryColor.withOpacity(.5),
          ),
        );
      }),
    );
  }
}
