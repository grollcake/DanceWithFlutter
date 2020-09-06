import 'package:flutter/material.dart';
import 'package:login_dice/pages/dice_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                print('menu pressed');
              }),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () => print('search pressed'))],
        ),
        body: LoginBody());
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _txt1 = TextEditingController();
  TextEditingController _txt2 = TextEditingController();

  void _loginBtnAction(BuildContext context) {
    if (_txt1.text.trim() != 'dice') {
      _showSnackBar(context, '올바른 ID를 입력하세요');
      return;
    } else if (_txt2.text.trim() != '1234') {
      _showSnackBar(context, '올바른 패스워드를 입력하세요');
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return DicePage();
    }));
  }

  void _showSnackBar(BuildContext context, String s) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(s, textAlign: TextAlign.center),
      duration: Duration(milliseconds: 1500),
      backgroundColor: Colors.amber,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Image(
                image: AssetImage('images/chef.gif'),
                height: 150.0,
                width: 180.0,
              ),
              SizedBox(height: 50.0),
              Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _txt1,
                      decoration: InputDecoration(labelText: 'Enter "dice'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _txt2,
                      decoration: InputDecoration(labelText: 'Enter "1234'),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              FlatButton(
                color: Colors.amberAccent,
                onPressed: () => _loginBtnAction(context),
                child: Icon(Icons.arrow_forward, size: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
