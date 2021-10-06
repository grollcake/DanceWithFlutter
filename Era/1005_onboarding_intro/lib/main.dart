import 'package:flutter/material.dart';
import 'package:onboarding_intro2/screens/onboarding/onboarding_screen.dart';

void main() => runApp(
  MaterialApp(
    title: 'onboarding',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: const OnboardingScreen(),
  )
);
