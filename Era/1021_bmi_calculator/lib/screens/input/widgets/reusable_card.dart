import 'package:bmi_calculator/constants/app_style.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({Key? key, this.isActive = true, required this.child}) : super(key: key);
  final bool isActive;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isActive ? AppStyle.activeCardColor : AppStyle.inactiveCardColor,
      ),
      child: child,
    );
  }
}
