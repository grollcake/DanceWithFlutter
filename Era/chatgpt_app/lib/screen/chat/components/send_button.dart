import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

class SendButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const SendButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isActive ? onPressed : null,
      padding: EdgeInsets.all(2),
      icon: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? primaryColor.withOpacity(.8) : Colors.grey.shade400,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_upward_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
