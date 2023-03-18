import 'package:chatgpt_app/providers/providers.dart';
import 'package:chatgpt_app/screen/chat_sub/chat_sub_screen.dart';
import 'package:chatgpt_app/screen/not_yet/not_yet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/side_bar/side_bar.dart';
import '../../components/title_bar/title_bar.dart';

class ChatMainScreen extends ConsumerWidget {
  ChatMainScreen({Key? key}) : super(key: key);

  final List<String> _menuNames = ['친구', '채팅', '쪽지', '검색', 'IPT'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMenuIndex = ref.watch(selectedMenuProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: (deviceType == DeviceType.mobile) ? _buildSideBarMenu(ref) : null,
      body: Column(
        children: [
          TitleBar(),
          Expanded(
            child: Row(
              children: [
                if (deviceType != DeviceType.mobile) _buildSideBarMenu(ref),
                Expanded(
                  child: IndexedStack(
                    index: selectedMenuIndex,
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

  _buildSideBarMenu(WidgetRef ref) {
    return Builder(
      builder: (context) {
        return SideBarMenu(
          initialSelectedIndex: ref.watch(selectedMenuProvider),
          onChange: (index) {
              ref.watch(selectedMenuProvider.notifier).state = index;
              if (deviceType == DeviceType.mobile) Navigator.pop(context);
            },
        );
      }
    );
  }
}
