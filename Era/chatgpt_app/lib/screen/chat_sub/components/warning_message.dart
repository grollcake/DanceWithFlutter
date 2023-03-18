import 'package:flutter/material.dart';

class WarningMessage extends StatelessWidget {
  final String message;

  const WarningMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.pink.withOpacity(.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_rounded, color: Colors.pink),
          SizedBox(width: 12),
          Flexible(
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
