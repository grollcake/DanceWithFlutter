import 'package:flutter/material.dart';
import 'package:login_dice/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.purple[300])
        ),
        buttonTheme: ButtonThemeData(
          height: 40.0,
          minWidth: 120.0,
        ),
      ),
      home: LoginPage()
    );
  }
}
