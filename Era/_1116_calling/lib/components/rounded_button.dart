import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.iconPath, required this.color}) : super(key: key);
  final String iconPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          shape: CircleBorder(),
          primary: color,
          onPrimary: Colors.grey,
        ),
        child: SvgPicture.asset(iconPath, color: color == Colors.white ? Colors.black : Colors.white),
      ),
    );
  }
}
