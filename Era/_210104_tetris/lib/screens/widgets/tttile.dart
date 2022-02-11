import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/models/enums.dart';

class TTTile extends StatelessWidget {
  const TTTile({Key? key, required this.blockId, required this.status, this.color, this.typeId}) : super(key: key);
  final TTBlockID blockId;
  final TTBlockStatus status;
  final Color? color;
  final int? typeId;
  static const typeCount = 4;

  @override
  Widget build(BuildContext context) {
    Color color = this.color ?? AppSettings.tileColor(blockId);
    if (status == TTBlockStatus.shadow) {
      color = color.withOpacity(0.2);
    }
    return _getShape(typeId ?? AppSettings.tileTypeId, color);
  }

  static Widget _getShape(int id, [Color color = Colors.green]) {
    switch (id) {
      case 0:
        return TileType1(color: color);
      case 1:
        return TileType2(color: color);
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

class TileType1 extends StatelessWidget {
  const TileType1({Key? key, required this.color}) : super(key: key);
  final _adjustRatio = 0.10;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final currentValue = HSVColor.fromColor(color).value;
    final lightValue = min(currentValue + _adjustRatio, 1.0);
    Color lightColor = HSVColor.fromColor(color).withValue(lightValue).toColor();
    Color darkColor = lightValue < 1.0 ? color : HSVColor.fromColor(color).withValue(1 - _adjustRatio).toColor();

    return Stack(
      children: [
        ClipPath(
          clipper: TileType1Clipper(clippingSide: 'LB'),
          child: Container(
            color: darkColor,
          ),
        ),
        ClipPath(
          clipper: TileType1Clipper(clippingSide: 'RT'),
          child: Container(
            color: lightColor,
          ),
        ),
      ],
    );
  }
}

class TileType1Clipper extends CustomClipper<Path> {
  // 조각대상: LB-LeftBottom, RT-RightTop
  final String clippingSide;

  TileType1Clipper({required this.clippingSide});

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

class TileType2 extends StatelessWidget {
  const TileType2({Key? key, required this.color}) : super(key: key);
  final _adjustRatio = 0.10;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color lightColor = HSVColor.fromColor(color).withValue(1).toColor();

    var lightValue = max(HSVColor.fromColor(color).value - _adjustRatio, 0.0);
    final Color mediumColor = HSVColor.fromColor(color).withValue(lightValue).toColor();

    lightValue = max(HSVColor.fromColor(color).value - _adjustRatio * 2, 0.0);
    final Color darkColor = HSVColor.fromColor(color).withValue(lightValue).toColor();

    return Stack(
      children: [
        ClipPath(
          child: Container(
            color: mediumColor,
          ),
          clipper: TileType2Clipper(clippingSide: 'Left'),
        ),
        ClipPath(
          child: Container(
            color: mediumColor,
          ),
          clipper: TileType2Clipper(clippingSide: 'Right'),
        ),
        ClipPath(
          child: Container(
            color: lightColor,
          ),
          clipper: TileType2Clipper(clippingSide: 'Up'),
        ),
        ClipPath(
          child: Container(
            color: darkColor,
          ),
          clipper: TileType2Clipper(clippingSide: 'Down'),
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

class TileType2Clipper extends CustomClipper<Path> {
  final String clippingSide;

  TileType2Clipper({required this.clippingSide});

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

class TileType3 extends StatelessWidget {
  const TileType3({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}

class TileType4 extends StatelessWidget {
  const TileType4({Key? key, required this.color}) : super(key: key);
  final Color color;
  final _adjustRatio = 0.25;

  @override
  Widget build(BuildContext context) {
    final currentValue = HSVColor.fromColor(color).value;
    final lightValue = min(currentValue + _adjustRatio, 1.0);
    Color lightColor = HSVColor.fromColor(color).withValue(lightValue).toColor();
    Color darkColor = lightValue < 1.0 ? color : HSVColor.fromColor(color).withValue(1 - _adjustRatio).toColor();

    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [lightColor, darkColor],
          center: Alignment.center,
        ),
      ),
    );
  }
}
