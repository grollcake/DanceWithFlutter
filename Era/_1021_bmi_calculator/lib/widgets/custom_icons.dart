import 'package:flutter/material.dart';

class CustomMenuIcon extends StatelessWidget {
  const CustomMenuIcon({Key? key, this.size = 16.0, this.color = Colors.black}) : super(key: key);

  static const double defaultPadding = 4.0;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBar(size - defaultPadding * 2),
            buildBar((size - defaultPadding * 2) * .7),
            buildBar((size - defaultPadding * 2) * .4),
          ],
        ),
      ),
    );
  }

  Widget buildBar(double barSize) {
    return Container(
      width: barSize,
      height: size / 16 * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 16 * 2),
      ),
    );
  }
}
