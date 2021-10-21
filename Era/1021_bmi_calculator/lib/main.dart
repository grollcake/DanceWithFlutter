import 'package:bmi_calculator/constants/app_style.dart';
import 'package:bmi_calculator/screens/input/input_screen.dart';
import 'package:bmi_calculator/screens/result/result_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BMIApp());

class BMIApp extends StatelessWidget {
  const BMIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppStyle.backgroundColor,
      ),
      routes: {
        '/': (context) => InputScreen(),
        '/result': (context) => ResultScreen(),
      },
      initialRoute: '/',
    );
  }
}
