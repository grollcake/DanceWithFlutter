import 'package:calling/components/rounded_button.dart';
import 'package:calling/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(
      MaterialApp(
        title: 'Call App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headline3: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 40,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: CallingApp(),
      ),
    );

class CallingApp extends StatefulWidget {
  const CallingApp({Key? key}) : super(key: key);

  @override
  _CallingAppState createState() => _CallingAppState();
}

class _CallingAppState extends State<CallingApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/cruella.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Cruella\nDe Vil',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Incomming 00:01'.toUpperCase(),
                    style: TextStyle(color: Colors.white60),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(iconPath: 'assets/icons/Icon Mic.svg', color: Colors.white),
                      RoundedButton(iconPath: 'assets/icons/call_end.svg', color: Colors.red),
                      RoundedButton(iconPath: 'assets/icons/Icon Volume.svg', color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
