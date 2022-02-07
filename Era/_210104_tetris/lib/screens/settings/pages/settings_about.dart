import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';

class SettingsDetailAbout extends StatefulWidget {
  const SettingsDetailAbout({Key? key}) : super(key: key);

  @override
  _SettingsDetailAboutState createState() => _SettingsDetailAboutState();
}

class _SettingsDetailAboutState extends State<SettingsDetailAbout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Info', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor, fontWeight: FontWeight.bold)),
        Text('username: ${AppSettings.username}', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
        Text('userid: ${AppSettings.userId}', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
        Text('isWeb: $kIsWeb', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
      ],
    );
  }
}
