import 'package:bmi_calculator/pages/input_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
          primaryColor: Color(0xFF0A0D22), //#0A0D22
          scaffoldBackgroundColor: Color(0xFF0A0D22),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: InputPage()
    );
  }
}
