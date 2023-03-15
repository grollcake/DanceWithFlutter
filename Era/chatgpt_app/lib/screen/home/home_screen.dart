import 'package:chatgpt_app/screen/chat/chat_screen.dart';
import 'package:chatgpt_app/screen/not_yet/not_yet_screen.dart';
import 'package:flutter/material.dart';

import '../../components/side_bar/side_bar.dart';
import '../../components/title_bar/title_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _menuIndex = 5;
  final List<String> _menuNames = ['친구와 조직도', '채팅', '쪽지', '검색', 'IPT'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildAppBar(BuildContext context) {}

  _buildBody(BuildContext context) {
    return Column(
      children: [
        TitleBar(),
        Expanded(
          child: Row(
            children: [
              SideBar(
                menuIndex: 5,
                onChange: (index) {
                  setState(() {
                    _menuIndex = index;
                  });
                },
              ),
              Expanded(
                child: IndexedStack(
                  index: _menuIndex,
                  children: [
                    ...List.generate(_menuNames.length, (index) => NotYetScreen(screenName: '[${_menuNames[index]}]')),
                    ChatScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
