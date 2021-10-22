import 'package:bmi_calculator/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Drawer buildCustomDrawer(bool likeIt, VoidCallback onLikeTap) {
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }

  return Drawer(
    child: Container(
      color: AppStyle.activeCardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/984975?v=4'),
              ),
            ),
            Text('Era', style: AppStyle.resultTextStyle.copyWith(fontSize: 30)),
            SizedBox(height: 50),
            ListTile(
              leading: Icon(FontAwesomeIcons.code, color: Colors.white),
              title: Text('Source code', style: TextStyle(fontSize: 20, color: Colors.white)),
              onTap: () {
                launchUrl('https://github.com/grollcake/DanceWithFlutter/tree/master/Era/_1021_bmi_calculator');
              },
            ),
            ListTile(
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: Icon(
                  likeIt ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: likeIt ? Colors.pinkAccent : Colors.white,
                ),
              ),
              title: Text('Like it', style: TextStyle(fontSize: 20, color: Colors.white)),
              onTap: onLikeTap,
            ),
            Spacer(),
            Text('by Era. \'21.10.22', style: AppStyle.labelTextStyle),
          ],
        ),
      ),
    ),
  );
}
