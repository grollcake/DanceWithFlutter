import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_app_onboarding/screens/main_screen.dart';
import 'package:habit_app_onboarding/screens/onboarding_screen.dart';
import 'package:habit_app_onboarding/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 안드로이드 상단 상태바 숨김
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  return runApp(HabitApp());
}

class HabitApp extends StatelessWidget {
  const HabitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _seenOnboarding(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SplashScreen();
            case ConnectionState.done:
              return (snapshot.data ?? false) ? MainPage() : OnboardingScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }

  Future<bool> _seenOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('ONBOARDING_COMPLETE') ?? false;
    await Future.delayed(Duration(seconds: 3));
    return status;
  }
}
