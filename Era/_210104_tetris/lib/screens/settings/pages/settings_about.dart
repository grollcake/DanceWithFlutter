import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/constants.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Lottie.asset('assets/animations/lottie-space.json'),
        Image.asset('assets/images/space.gif'),
        SizedBox(height: 30),
        Text('Developed by ERA, 2022',
            style: TextStyle(fontSize: 16, color: AppStyle.accentColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('grollcake@gmail.com', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
        SizedBox(height: 30),
        Text('Source Code', style: TextStyle(fontSize: 14, color: Colors.grey)),
        ElevatedButton.icon(
          icon: Icon(FontAwesomeIcons.github, color: AppStyle.darkTextColor, size: 16),
          onPressed: () async {
            if (!await launch(
              kGithubUrl,
              forceSafariVC: false,
              forceWebView: false,
            )) throw 'Could not launch $kGithubUrl';
          },
          label: Text('Github', style: TextStyle(fontSize: 16, color: AppStyle.darkTextColor)),
          style: ElevatedButton.styleFrom(
            primary: AppStyle.accentColor,
            minimumSize: Size(160, 34),
          ),
        ),
        // Spacer(),
        // buildUserInfo(),
      ],
    );
  }

  Widget buildUserInfo() {
    String platform = defaultTargetPlatform.toString().split('.')[1];
    if (kIsWeb) {
      platform = '$platform (web)';
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: 6),
          child: Text(
            '사용자 정보',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 6),
          decoration: BoxDecoration(
            color: AppStyle.bgColorWeak,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Text(AppSettings.username ?? '이름 없음',
                  style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text(AppSettings.userId ?? '아이디 없음', style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 2),
              Text(platform, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
