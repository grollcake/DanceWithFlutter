import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDEE2E6),
            width: 2,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Text('Shinny', style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('AI Bot', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Spacer(),
          Image.asset('assets/icons/chattoolbars.png'),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
