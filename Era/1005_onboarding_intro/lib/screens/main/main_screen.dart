import 'package:flutter/material.dart';
import 'package:onboarding_intro2/constants/styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Text('Amki coding by Era, 2021.10.05',
            style: TextStyle(fontSize: 20, color: AppStyle.primary, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
