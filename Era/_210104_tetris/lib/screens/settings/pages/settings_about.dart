import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';

class SettingsDetailAbout extends StatefulWidget {
  const SettingsDetailAbout({Key? key}) : super(key: key);

  @override
  _SettingsDetailAboutState createState() => _SettingsDetailAboutState();
}

class _SettingsDetailAboutState extends State<SettingsDetailAbout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Not yet developed', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
      ),
    );
  }
}
