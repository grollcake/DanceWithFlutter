import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/screens/settings/pages/settings_about.dart';
import 'package:tetris/screens/settings/pages/settings_block.dart';
import 'package:tetris/screens/settings/pages/settings_code.dart';
import 'package:tetris/screens/settings/pages/settings_misc.dart';
import 'package:tetris/screens/settings/pages/settings_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const defalutPadding = 12.0;
  List<String> menus = ['Theme', 'Block', 'Misc', 'Code', 'About'];

  final List _settingsDetailPage = [
    SettingsDetailTheme(),
    SettingsDetailBlock(),
    SettingsDetailMisc(),
    SettingsDetailCode(),
    SettingsDetailAbout(),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: defalutPadding),
        decoration: BoxDecoration(color: AppStyle.bgColor.withOpacity(1.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: buildTitleBar(),
            ),
            SizedBox(height: defalutPadding),
            SizedBox(
              height: 500,
              child: Row(
                children: [
                  SizedBox(
                    width: 76,
                    height: double.infinity,
                    child: ListView.builder(
                      itemCount: menus.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              AppSettings.selectedMenuIndex = index;
                            });
                          },
                          title: Text(
                            menus[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: index == AppSettings.selectedMenuIndex ? Colors.yellowAccent : Colors.grey,
                              fontWeight: index == AppSettings.selectedMenuIndex ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey.shade700,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 21),
                      // color: AppStyle.bgColor.withOpacity(0.95),
                      child: _settingsDetailPage[AppSettings.selectedMenuIndex],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack buildTitleBar() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text('T E T R I S', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Align(
          alignment: Alignment(1, 0),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
