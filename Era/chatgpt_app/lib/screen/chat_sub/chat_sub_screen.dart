import 'package:flutter/material.dart';

import 'sections/body_section.dart';
import 'sections/header_section.dart';
import 'sections/input_section.dart';

class ChatSubScreen extends StatelessWidget {
  const ChatSubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSection(menuName: 'Shinny'),
        Expanded(
          child: ChatBody(),
        ),
        InputSection(),
      ],
    );
  }
}
