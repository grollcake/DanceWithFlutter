import 'package:flutter/material.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/screens/settings/widgets/subtitle.dart';
import 'package:tetris/screens/settings/widgets/selectedItem.dart';
import 'package:tetris/screens/widgets/tttile.dart';

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
        // BlockColorSets
        buildColorChoice(),
        SizedBox(height: 30),
        // Tile Shapes
        buildShapeChoice(),
        SizedBox(height: 30),
        // Preview label
        buildPreview(),
      ],
    );
  }

  Widget buildColorChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: 'Color set'),
        GridView.builder(
          shrinkWrap: true,
          itemCount: AppSettings.colorSets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 4.0,
            mainAxisExtent: 30.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  AppSettings.colorSetId = index;
                });
              },
              child: SelectedItem(
                selected: index == AppSettings.colorSetId,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index2) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      width: 14,
                      height: 14,
                      color: AppSettings.colorSets[index][index2],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildShapeChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: 'Tile'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            TTTile.typeCount,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  AppSettings.tileTypeId = index;
                });
              },
              child: SelectedItem(
                selected: index == AppSettings.tileTypeId,
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
      ],
    );
  }

  Widget buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: 'Preview'),
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          // color: AppStyle.bgColorAccent,
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
