import 'package:flutter/material.dart';

import 'sections/body_section.dart';
import 'sections/header_section.dart';
import 'sections/input_section.dart';

class BodySection extends StatelessWidget {
  const BodySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSection(),
        Expanded(
          child: ChatBody(),
        ),
        InputSection(),
      ],
    );
  }
}
