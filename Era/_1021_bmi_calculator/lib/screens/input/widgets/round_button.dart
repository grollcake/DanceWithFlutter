import 'package:bmi_calculator/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({Key? key, required this.onPressed, required this.icon}) : super(key: key);
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: AppStyle.backgroundColor,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: 42,
        height: 42,
      ),
      // constraints: BoxConstraints(
      //   minWidth: 42,
      //   minHeight: 42,
      // ),
      child: Center(child: Icon(icon, size: 24, color: Colors.white70)),
    );
  }
}
