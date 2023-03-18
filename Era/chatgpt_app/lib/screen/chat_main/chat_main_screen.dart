import 'package:chatgpt_app/providers/providers.dart';
import 'package:chatgpt_app/screen/chat_sub/chat_sub_screen.dart';
import 'package:chatgpt_app/screen/not_yet/not_yet_screen.dart';
import 'package:flutter/material.dart';

import '../../components/side_bar/side_bar.dart';
import '../../components/title_bar/title_bar.dart';

class ChatMainScreen extends StatefulWidget {
  ChatMainScreen({Key? key}) : super(key: key);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  int _selectedMenuIndex = 5;
  final List<String> _menuNames = ['친구', '채팅', '쪽지', '검색', 'IPT'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: (deviceType == DeviceType.mobile) ? _buildSideBarMenu() : null,
      body: Column(
        children: [
          TitleBar(),
          Expanded(
            child: Row(
              children: [
                if (deviceType != DeviceType.mobile) _buildSideBarMenu(),
                Expanded(
                  child: IndexedStack(
                    index: _selectedMenuIndex,
                    children: [
                      ...List.generate(
                          _menuNames.length, (index) => NotYetScreen(menuName: _menuNames[index])),
                      ChatSubScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSideBarMenu() {
    return SideBarMenu(
      initialSelectedIndex: _selectedMenuIndex,
      onChange: (index) {
        setState(() {
          _selectedMenuIndex = index;
          if (deviceType == DeviceType.mobile) Navigator.of(context).pop();
        });
      },
    );
  }
}
