import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/widgets/selectedItem.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const defalutPadding = 12.0;
  List<String> menus = ['Theme', 'Block', 'Swipe', 'Code', 'About'];
  int selectedMenuIndex = 0;
  int selectedColorIndex = 0;
  int selectedShapeIndex = 0;

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
                  Container(
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
                  Container(
                    width: 1.0,
                    height: double.infinity,
                    color: Colors.grey.shade700,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 21),
                      // color: AppStyle.bgColor.withOpacity(0.95),
                      child: buildThemeSettings(),
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

  Column buildThemeSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Color label
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Color',
            style: TextStyle(
              fontSize: 14,
              color: AppStyle.lightTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // BlockColorSets
        GridView.builder(
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            mainAxisExtent: 30.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColorIndex = index;
                  AppStyle.colorSetId = index;
                });
              },
              child: SelectedItem(
                selected: index == selectedColorIndex ? true : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      width: 14,
                      height: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40),
        // Shape label
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Shape',
            style: TextStyle(
              fontSize: 14,
              color: AppStyle.lightTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Tile Shapes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            AppStyle.tileShapes.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedShapeIndex = index;
                });
              },
              child: SelectedItem(
                selected: index == selectedShapeIndex,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppStyle.tileShapes[index],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        // Preview label
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Preview',
            style: TextStyle(
              fontSize: 14,
              color: AppStyle.lightTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width: 2,
          //     color: Colors.white,
          //   ),
          // ),
          child: Column(
            children: List.generate(_previewMatrix.length, (row) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_previewMatrix[row].length, (col) {
                  Color color = _previewMatrix[row][col] == null
                      ? Colors.transparent
                      : AppStyle.blockColor(_previewMatrix[row][col]!);
                  return Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.all(1),
                    color: color,
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }

  Stack buildTitleBar() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text('Settings', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
