import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDetailCode extends StatefulWidget {
  const SettingsDetailCode({Key? key}) : super(key: key);

  @override
  _SettingsDetailCodeState createState() => _SettingsDetailCodeState();
}

class _SettingsDetailCodeState extends State<SettingsDetailCode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Image.asset('assets/images/code.png'),
        ),
        SizedBox(height: 40),
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
      ],
    );
  }
}
