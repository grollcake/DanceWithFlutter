import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  // 구글 로그인을 하기 위한 객체
  final GoogleSignIn _googleSignIN = GoogleSignIn();
  // Firebase인증 정보
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Instagram Clone",
              style: GoogleFonts.pacifico(fontSize: 40.0)
            ),
            SizedBox(
              height: 80.0,
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSignIn();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIN.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = (await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, 
        accessToken: googleAuth.accessToken))).user;
    print("Sign in : " + user.displayName);
    return user;
  }


}