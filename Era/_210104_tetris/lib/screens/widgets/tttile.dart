import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/models/enums.dart';

class TTTile extends StatelessWidget {
  const TTTile({Key? key, required this.blockId, required this.status}) : super(key: key);
  final TTBlockID blockId;
  final TTBlockStatus status;
  static const typeCount = 4;

  @override
  Widget build(BuildContext context) {
    Color color = AppSettings.tileColor(blockId);
    if (status == TTBlockStatus.shadow) {
      color = color.withOpacity(0.2);
    }
    return _getShape(AppSettings.tileTypeId, color);
  }

  static Widget _getShape(int id, [Color color = AppStyle.accentColor]) {
    switch (id) {
      case 0:
        return Container(
          decoration: BoxDecoration(
            color: color,
          ),
        );
      case 1:
        return Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      case 2:
        return TileType3(color: color);
      case 3:
        return TileType4(color: color);
    }
    return SizedBox();
  }

  static Widget shapeType(int index) {
    return _getShape(index);
  }
}

class TileType3 extends StatelessWidget {
  const TileType3({Key? key, required this.color}) : super(key: key);
  final _adjustRatio = 0.30;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final lightValue = min(HSVColor.fromColor(color).value * (_adjustRatio + 1), 1.0);
    Color lightColor = HSVColor.fromColor(color).withValue(lightValue).toColor();
    return Stack(
      children: [
        ClipPath(
          clipper: TileType3Clipper(clippingSide: 'LB'),
          child: Container(
            color: color,
          ),
        ),
        ClipPath(
          clipper: TileType3Clipper(clippingSide: 'RT'),
          child: Container(
            color: lightColor,
          ),
        ),
      ],
    );
  }
}

class TileType3Clipper extends CustomClipper<Path> {
  // 조각대상: LB-LeftBottom, RT-RightTop
  final String clippingSide;

  TileType3Clipper({required this.clippingSide});

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (clippingSide == 'LB') {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else if (clippingSide == 'RT') {
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TileType4 extends StatelessWidget {
  const TileType4({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color lightColor = HSVColor.fromColor(color).withValue(1).toColor();

    var lightValue = max(HSVColor.fromColor(color).value - 0.15, 0.0);
    final Color mediumColor = HSVColor.fromColor(color).withValue(lightValue).toColor();

    lightValue = max(HSVColor.fromColor(color).value - 0.3, 0.0);
    final Color darkColor = HSVColor.fromColor(color).withValue(lightValue).toColor();

    return Stack(
      children: [
        ClipPath(
          child: Container(
            color: mediumColor,
          ),
          clipper: TileType4Clipper(clippingSide: 'Left'),
        ),
        ClipPath(
          child: Container(
            color: mediumColor,
          ),
          clipper: TileType4Clipper(clippingSide: 'Right'),
        ),
        ClipPath(
          child: Container(
            color: lightColor,
          ),
          clipper: TileType4Clipper(clippingSide: 'Up'),
        ),
        ClipPath(
          child: Container(
            color: darkColor,
          ),
          clipper: TileType4Clipper(clippingSide: 'Down'),
        ),
        LayoutBuilder(builder: (context, size) {
          return Container(
            margin: EdgeInsets.all(size.maxWidth * .15),
            color: color,
          );
        }),
      ],
    );
  }
}

class TileType4Clipper extends CustomClipper<Path> {
  final String clippingSide;

  TileType4Clipper({required this.clippingSide});

  @override
  Path getClip(Size size) {
    Path path = Path();
    switch (clippingSide) {
      case 'Left':
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case 'Right':
        path.moveTo(size.width, 0);
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case 'Up':
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(size.width, 0);
        break;
      case 'Down':
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}