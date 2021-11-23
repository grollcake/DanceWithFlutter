import 'package:flutter/material.dart';
import 'package:login_screen/constants/app_styles.dart';
import 'package:login_screen/screens/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Hero(
              tag: 'introImage',
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/intro.jpeg')),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'BAKING LESSONS\n', style: Theme.of(context).textTheme.headline1),
                      TextSpan(text: 'MASTER THE ART OF BAKING', style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ),
                Spacer(),
                FittedBox(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen())),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'START LEARNING',
                          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.black)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
