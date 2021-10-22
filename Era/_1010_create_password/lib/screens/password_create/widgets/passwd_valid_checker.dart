import 'package:flutter/material.dart';

class PasswordValidChecker extends StatelessWidget {
  const PasswordValidChecker({Key? key, required this.isValid, required this.message}) : super(key: key);

  final bool isValid;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isValid ? Colors.green : Colors.white,
            border: Border.all(
              color: isValid ? Colors.transparent : Colors.grey,
            ),
          ),
          child: Center(
            child: Icon(Icons.check, color: Colors.white, size: 14),
          ),
        ),
        SizedBox(width: 10),
        Text(message, style: TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}
