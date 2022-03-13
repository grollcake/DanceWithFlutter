import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: Color(0xFFF9F9F9),
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black54),
      bodyText2: TextStyle(color: Colors.black26),
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Color(0xFF292D3E),
    scaffoldBackgroundColor: Color(0xFF292D3E),
    iconTheme: IconThemeData(
      color: Colors.white30,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white10),
    ),
  );

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
