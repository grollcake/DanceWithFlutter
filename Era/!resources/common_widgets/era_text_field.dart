import 'package:flutter/material.dart';

enum EraTextFieldType { email, password, custom }

class EraTextField extends StatefulWidget {
  final EraTextFieldType type;
  final String hintText;
  final IconData? iconData;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Color? bgColor;

  const EraTextField({
    super.key,
    required this.type,
    this.iconData,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.bgColor,
  });

  @override
  State<EraTextField> createState() => _EraTextFieldState();
}

class _EraTextFieldState extends State<EraTextField> {
  bool _visibility = false;

  _toggleVisibility() {
    setState(() => _visibility = !_visibility);
  }

  @override
  Widget build(BuildContext context) {
    final IconData? iconData;

    switch (widget.type) {
      case EraTextFieldType.email:
        iconData = Icons.email_outlined;
        break;
      case EraTextFieldType.password:
        iconData = Icons.lock_outline;
        break;
      case EraTextFieldType.custom:
        iconData = widget.iconData;
    }

    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.bgColor ?? Colors.white,
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.type == EraTextFieldType.password ? !_visibility : false,
        decoration: InputDecoration(
            filled: false,
            border: InputBorder.none,
            prefixIcon: Icon(iconData, size: 18, color: Colors.black54),
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            suffixIcon: widget.type == EraTextFieldType.password
                ? IconButton(
                    icon: Icon(_visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        size: 18, color: Colors.black54),
                    onPressed: _toggleVisibility,
                  )
                : null),
      ),
    );
  }
}
