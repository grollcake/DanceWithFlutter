import 'package:chatgpt_app/screen/chat_sub/sections/header_section.dart';
import 'package:flutter/material.dart';

class NotYetScreen extends StatelessWidget {
  final String menuName;

  const NotYetScreen({Key? key, required this.menuName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSection(menuName: menuName),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/na.png', width: 70),
                SizedBox(height: 20),
                Text('이 기능은 준비되지 않았습니다\nShinny만 이용 가능합니다',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
