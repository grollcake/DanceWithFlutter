import 'package:flutter/material.dart';

import 'dice_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => print('menu pressed'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print('search pressed'),
          ),
        ],
      ),
      body: LoginPageBody()
    );
  }
}

class LoginPageBody extends StatefulWidget {
  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  TextEditingController _text1 = TextEditingController();
  TextEditingController _text2 = TextEditingController();

  void _loginAction(BuildContext context) {
    if (_text1.text != 'dice') {
      _showSnackBar(context, '올바른 아이디를 입력하세요');
    }
    else if (_text2.text != '1234') {
      _showSnackBar(context, '올바른 패스워드를 입력하세요');
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return DicePage();
      }));
    }
  }

  void _showSnackBar(BuildContext context, String s) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
        backgroundColor: Colors.amber,
        duration: Duration(milliseconds: 2200),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/chef.gif'),
                width: 180.0,
                height: 150.0,
              ),
              Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _text1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Input "dice"',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _text2,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Input "1234"',
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.orange,
                onPressed: () => _loginAction(context),
                child: Icon(Icons.arrow_forward, size: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
