import 'package:chatgpt_app/constants/styles.dart';
import 'package:chatgpt_app/model/chat_model.dart';
import 'package:flutter/material.dart';

class ToneIndicator extends StatelessWidget {
  final ChatTone tone;
  const ToneIndicator({Key? key, required this.tone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: toneColors[tone.index].withOpacity(.5),
      ),
    );
  }
}
