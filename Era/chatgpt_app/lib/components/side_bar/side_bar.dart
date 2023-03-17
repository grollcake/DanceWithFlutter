import 'package:chatgpt_app/constants/styles.dart';
import 'package:flutter/material.dart';

import '../shinny.dart';

class SideBar extends StatefulWidget {
  final int menuIndex;
  final ValueChanged<int> onChange;

  const SideBar({Key? key, this.menuIndex = 0, required this.onChange}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _menuIndex = 0;

  final List<Widget> _inactiveMenuIcons = [
    Image.asset('assets/icons/people.png'),
    Image.asset('assets/icons/message.png'),
    Image.asset('assets/icons/dm.png'),
    Image.asset('assets/icons/search.png'),
    Image.asset('assets/icons/phone.png'),
    Shinny(active: false),
  ];

  final List<Widget> _activeMenuIcons = [
    Image.asset('assets/icons/people.png', color: primaryColor),
    Image.asset('assets/icons/message.png', color: primaryColor),
    Image.asset('assets/icons/dm.png', color: primaryColor),
    Image.asset('assets/icons/search.png', color: primaryColor),
    Image.asset('assets/icons/phone.png', color: primaryColor),
    Shinny(active: true),
  ];

  @override
  void initState() {
    super.initState();
    _menuIndex = widget.menuIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: double.infinity,
      decoration: BoxDecoration(color: primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(_inactiveMenuIcons.length, (index) {
            return GestureDetector(
              onTap: () {
                widget.onChange(index);
                setState(() => _menuIndex = index);
              },
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _menuIndex == index ? Colors.white : Colors.transparent,
                    ),
                    child:  _menuIndex == index ? _activeMenuIcons[index] : _inactiveMenuIcons[index],
                    ),
                ),
                ),
            );
          }),
          Spacer(),
          Image.asset('assets/icons/etc.png'),
        ],
      ),
    );
  }
}