import 'package:flutter/material.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.mode_night, size: 26, color: AppStyle.inactiveTextColor),
      ),
    );
  }
}
