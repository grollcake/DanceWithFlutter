import 'package:dice_app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice app',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 15.0, color: Colors.pink),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 150.0,
          height: 60.0
        ),
      ),
      home: LoginPage()
    );
  }
}
