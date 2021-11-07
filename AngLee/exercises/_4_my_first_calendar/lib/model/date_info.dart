import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class DateInfo {
  bool isBlank = false;

  String year = '';
  String month = '';
  String day = '';

  int dayOfWeek = 0;

  IconData wIcons = WeatherIcons.na;
  bool hasWeatherInfo = false;


  String getFullDate(){
    return '${year}-${getLpad(month)}-${getLpad(day)}';
  }

  String getLpad(String str){
    return str.padLeft(2, '0');
  }
}