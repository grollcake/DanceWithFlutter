import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/screens/widgets/settings_details.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const defalutPadding = 12.0;
  List<String> menus = ['Theme', 'Block', 'Swipe', 'Code', 'About'];
  int selectedMenuIndex = 0;

  final List _settingsDetailPage = [
    SettingsDetailTheme(),
    SettingsDetailBlock(),
    SettingsDetailSwipe(),
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
                              selectedMenuIndex = index;
                            });
                          },
                          title: Text(
                            menus[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: index == selectedMenuIndex ? Colors.yellowAccent : Colors.grey,
                              fontWeight: index == selectedMenuIndex ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  VerticalDivider(color: Colors.grey.shade700, width: 2),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 21),
                      // color: AppStyle.bgColor.withOpacity(0.95),
                      child: _settingsDetailPage[selectedMenuIndex],
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
