import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/screens/settings/widgets/subtitle.dart';
import 'package:tetris/screens/settings/widgets/selectedItem.dart';

class SettingsDetailTheme extends StatefulWidget {
  const SettingsDetailTheme({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsDetailTheme> createState() => _SettingsDetailThemeState();
}

class _SettingsDetailThemeState extends State<SettingsDetailTheme> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: 'Background image'),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: settings.backgroundImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.3,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => settings.backgroundImageId = index,
                child: SelectedItem(
                  isSelected: index == settings.backgroundImageId,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(settings.backgroundImages[index]), fit: BoxFit.cover)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
