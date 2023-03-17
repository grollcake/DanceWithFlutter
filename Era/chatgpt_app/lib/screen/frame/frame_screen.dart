import 'package:chatgpt_app/screen/frame/sections/info_section.dart';
import 'package:chatgpt_app/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

class FrameScreen extends StatelessWidget {
  const FrameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB86BF8).withOpacity(.2), Color(0xFF6BB5F8).withOpacity(.2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: InfoSection()),
          SizedBox(width: 40),
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
              maxHeight: 1200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Colors.black54,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(10, 10),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MainScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
