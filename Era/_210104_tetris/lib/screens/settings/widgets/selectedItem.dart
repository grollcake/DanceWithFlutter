import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  SelectedItem({Key? key, required this.child, required this.selected}) : super(key: key);
  final Widget child;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: selected ? Colors.yellowAccent : Colors.transparent),
        ),
      ),
      child: child,
    );
  }
}
