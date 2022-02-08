import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/screens/settings/widgets/selectedItem.dart';
import 'package:tetris/screens/settings/widgets/subtitle.dart';

class SettingsDetailMisc extends StatefulWidget {
  const SettingsDetailMisc({Key? key}) : super(key: key);

  @override
  _SettingsDetailMiscState createState() => _SettingsDetailMiscState();
}

class _SettingsDetailMiscState extends State<SettingsDetailMisc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Background Music
        buildBackgroundMusicChoice(),
        SizedBox(height: 30),
        // Sound effect
        buildSoundEffectChoice(),
        SizedBox(height: 30),
        // GridLine
        buildGridlineChoice(),
        SizedBox(height: 30),
        // Shadow block
        buildShadowBlockChoice(),
      ],
    );
  }

  Widget buildBackgroundMusicChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: '배경음악'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.backgroundMusic = true;
              }),
              child: SelectedItem(
                selected: AppSettings.backgroundMusic,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('On', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.backgroundMusic = false;
              }),
              child: SelectedItem(
                selected: !AppSettings.backgroundMusic,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('Off', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSoundEffectChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: '효과음'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.soundEffect = true;
              }),
              child: SelectedItem(
                selected: AppSettings.soundEffect,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('On', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.soundEffect = false;
              }),
              child: SelectedItem(
                selected: !AppSettings.soundEffect,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('Off', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGridlineChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: '안내선'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.showGridLine = true;
              }),
              child: SelectedItem(
                selected: AppSettings.showGridLine,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('On', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.showGridLine = false;
              }),
              child: SelectedItem(
                selected: !AppSettings.showGridLine,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('Off', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildShadowBlockChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: '그림자 블록'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.showShadowBlock = true;
              }),
              child: SelectedItem(
                selected: AppSettings.showShadowBlock,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('On', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                AppSettings.showShadowBlock = false;
              }),
              child: SelectedItem(
                selected: !AppSettings.showShadowBlock,
                child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('Off', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
