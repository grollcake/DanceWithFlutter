import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tetris/constants/app_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.text, this.onPressed, this.isLoading = false, this.width = 160, this.height = 40})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: !isLoading
            ? Text(text, style: TextStyle(fontSize: 18, color: AppStyle.darkTextColor))
            : SizedBox(
                width: width,
                height: height,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Lottie.asset('assets/animations/loading.json', width: 160),
                ),
              ),
        style: ElevatedButton.styleFrom(
          primary: AppStyle.accentColor,
        ),
      ),
    );
  }
}
