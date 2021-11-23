import 'package:flutter/material.dart';
import 'package:login_screen/constants/app_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  image: DecorationImage(
                    image: AssetImage('assets/images/intro.jpeg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
              child: Column(
                children: [
                  // Signin text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SIGNIN', style: Theme.of(context).textTheme.headline1),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(fontSize: 16, color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Email textfield
                  Row(
                    children: [
                      Icon(Icons.alternate_email, color: kPrimaryColor),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey.shade300, fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Password textfield
                  Row(
                    children: [
                      Icon(Icons.lock, color: kPrimaryColor),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey.shade300, fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // 3 buttons
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          padding: EdgeInsets.all(12),
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: FaIcon(FontAwesomeIcons.twitter, color: Colors.grey.shade300),
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          padding: EdgeInsets.all(12),
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: FaIcon(FontAwesomeIcons.facebookF, color: Colors.grey.shade300),
                      ),
                      Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: kPrimaryColor,
                          side: BorderSide.none,
                          padding: EdgeInsets.all(12),
                        ),
                        child: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
