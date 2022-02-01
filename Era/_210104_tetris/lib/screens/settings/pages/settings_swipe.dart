import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';

class SettingsDetailSwipe extends StatefulWidget {
  const SettingsDetailSwipe({Key? key}) : super(key: key);

  @override
  _SettingsDetailSwipeState createState() => _SettingsDetailSwipeState();
}

class _SettingsDetailSwipeState extends State<SettingsDetailSwipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Not yet developed', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
      ),
    );
  }
}
