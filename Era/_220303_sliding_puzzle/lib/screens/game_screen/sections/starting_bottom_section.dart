import 'package:flutter/material.dart';
import 'package:sliding_puzzle/settings/app_style.dart';

class StartingBottomSection extends StatefulWidget {
  const StartingBottomSection({Key? key}) : super(key: key);

  @override
  State<StartingBottomSection> createState() => _StartingBottomSectionState();
}

class _StartingBottomSectionState extends State<StartingBottomSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        'Shuffling..',
        style: TextStyle(fontSize: 16, color: AppStyle.inactiveTextColor),
      ),
    );
  }
}
