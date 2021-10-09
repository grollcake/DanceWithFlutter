import 'package:flutter/material.dart';
import 'package:habit_app_onboarding/utils/size_config.dart';

class AppStyle {
  static Color primaryColor = Color(0xfffc9045);
  static Color secondaryColor = Color(0xff573353);

  static TextStyle titleText = TextStyle(
    fontFamily: 'Klasik',
    fontSize: SizeConfig.blockW! * 7,
    color: secondaryColor,
  );
  static TextStyle bodyText = TextStyle(
    fontFamily: 'Klasik',
    fontSize: SizeConfig.blockW! * 4.5,
    color: secondaryColor,
  );
}
