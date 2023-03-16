import 'package:chatgpt_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class FrameScreen extends StatelessWidget {
  const FrameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: 1200,
        height: 1000,
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: 900,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black26,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              offset: Offset(10,10),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: HomeScreen(),
      ),
    );
  }
}
