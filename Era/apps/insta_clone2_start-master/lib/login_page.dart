import 'dart:async';

import 'package:chapter10/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'tab_page.dart';

class LoginPage extends StatelessWidget {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Instagram Clone',
              style: GoogleFonts.pacifico(
                fontSize: 40.0,
              ),
            ),
            Container(
              margin: EdgeInsets.all(50.0),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSignin();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TabPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Google 로그인 후 FirebaseUser를 반환
  Future<FirebaseUser> _handleSignin() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    // 구글 로그인으로 인증된 정보로 FirebaseUser 객체 생성
    FirebaseUser user = (await firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken:googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      )
    )).user;

    // 로그인 정보 출력
    print('User: ' + user.displayName);
    return user;
  }

}
