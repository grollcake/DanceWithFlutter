import 'package:chatgpt_app/providers/providers.dart';
import 'package:flutter/material.dart';

import '../chat_main/chat_main_screen.dart';
import 'sections/info_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _chatScreenKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    switch (deviceType) {
      case DeviceType.mobile:
        return ChatMainScreen(key: _chatScreenKey);
      case DeviceType.tablet:
        return ChatMainScreen(key: _chatScreenKey);
      case DeviceType.desktop:
        return _desktopLayout();
      case DeviceType.tiny:
        return _tinyLayout();
    }
  }

  Widget _tinyLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB86BF8).withOpacity(.2), Color(0xFF6BB5F8).withOpacity(.2)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 1,
                height: 1,
                child: Offstage(
                  offstage: true,
                  child: ChatMainScreen(key: _chatScreenKey),
                ),
              ),
              Image.asset('assets/icons/monitor.png'),
              SizedBox(height: 24),
              Text(
                '화면이 너무 작습니다.\n데스크탑 브라우저를 이용해주세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text('최소 370 x 660 필요 (현재: ${constraints.maxWidth.toInt()} x ${constraints.maxHeight.toInt()})',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
        ),
      );
    });
  }

  Widget _desktopLayout() {
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
              child: ChatMainScreen(key: _chatScreenKey),
            ),
          ),
        ],
      ),
    );
  }
}
