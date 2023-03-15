import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 32,
      decoration: BoxDecoration(
        color: Color(0xFFF4F6F8),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDEE2E6),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Image.asset('assets/icons/shinhan.png'),
          ),
          Spacer(),
          Image.asset('assets/icons/toobuttons.png'),
        ],
      ),
    );
  }
}
