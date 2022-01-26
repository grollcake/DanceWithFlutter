import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/widgets/selectedItem.dart';
import 'package:tetris/screens/widgets/tttile.dart';

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
    return Container(
      child: Center(
        child: Text('Not yet developed', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
      ),
    );
  }
}

class SettingsDetailBlock extends StatefulWidget {
  const SettingsDetailBlock({Key? key}) : super(key: key);

  @override
  _SettingsDetailBlockState createState() => _SettingsDetailBlockState();
}

class _SettingsDetailBlockState extends State<SettingsDetailBlock> {
  final List<List<TTBlockID?>> _previewMatrix = [
    [null, TTBlockID.O, TTBlockID.O, null, TTBlockID.T, null],
    [null, TTBlockID.O, TTBlockID.O, TTBlockID.T, TTBlockID.T, TTBlockID.T],
    [null, TTBlockID.Z, TTBlockID.J, TTBlockID.L, TTBlockID.S, null],
    [TTBlockID.Z, TTBlockID.Z, TTBlockID.J, TTBlockID.L, TTBlockID.S, TTBlockID.S],
    [TTBlockID.Z, TTBlockID.J, TTBlockID.J, TTBlockID.L, TTBlockID.L, TTBlockID.S],
    [null, TTBlockID.I, TTBlockID.I, TTBlockID.I, TTBlockID.I, null]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Color label
        SettingsSubtitle(title: 'Color set'),
        // BlockColorSets
        GridView.builder(
          shrinkWrap: true,
          itemCount: AppStyle.colorSets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 4.0,
            mainAxisExtent: 30.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(
                  () {
                    AppStyle.colorSetId = index;
                  },
                );
              },
              child: SelectedItem(
                selected: index == AppStyle.colorSetId,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index2) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      width: 14,
                      height: 14,
                      color: AppStyle.colorSets[index][index2],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        // Shape label
        SettingsSubtitle(title: 'Shape'),
        // Tile Shapes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            TTTile.typeCount,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  TTTile.typeId = index;
                });
              },
              child: SelectedItem(
                selected: index == TTTile.typeId,
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TTTile.shapeType(index),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        // Preview label
        SettingsSubtitle(title: 'Preview'),
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          color: AppStyle.bgColorAccent,
          child: Column(
            children: List.generate(_previewMatrix.length, (row) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_previewMatrix[row].length, (col) {
                  Widget previewTile = SizedBox();
                  if (_previewMatrix[row][col] != null) {
                    previewTile = TTTile(blockId: _previewMatrix[row][col]!, status: TTBlockStatus.fixed);
                  }
                  return Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.all(1.0),
                    child: previewTile,
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }
}

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

class SettingsDetailCode extends StatefulWidget {
  const SettingsDetailCode({Key? key}) : super(key: key);

  @override
  _SettingsDetailCodeState createState() => _SettingsDetailCodeState();
}

class _SettingsDetailCodeState extends State<SettingsDetailCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Not yet developed', style: TextStyle(fontSize: 14, color: AppStyle.lightTextColor)),
      ),
    );
  }
}

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

////////////////////////////////////////////////////////////////
// Inner widgets
////////////////////////////////////////////////////////////////
class SettingsSubtitle extends StatelessWidget {
  const SettingsSubtitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: AppStyle.lightTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
