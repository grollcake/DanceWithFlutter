import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'loading_page.dart';
import 'tab_page.dart';

class RootPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return _handleCurrentScreen();
  }
  
  Widget _handleCurrentScreen() {
    return StreamBuilder(
      //로그인, 로그아웃과 같은 이벤트 시에 steam이 바뀜
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //연결 상태가 기다리는 중이라면 로딩 페이지를 변환
        if(snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          if(snapshot.hasData) {
            return TabPage(snapshot.data);
          }
          return LoginPage();
        }
      },
    );
  }
}