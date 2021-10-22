import 'package:bmi_calculator/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

AppBar buildCustomAppbar(String title, GlobalKey<ScaffoldState> appBarKey) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        appBarKey.currentState!.openDrawer();
      },
      // icon: CustomMenuIcon(size: 24, color: Colors.yellow,),
      icon: CustomMenuIcon(size: 24, color: Colors.white),
    ),
    title: Text(title),
    centerTitle: true,
    backgroundColor: Color(0xFF0A0E21),
    elevation: 8.0,
  );
}
