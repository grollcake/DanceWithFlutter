import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const CreateAccount());

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CreateAccount',
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _visible = true;
  bool _isEightPassword = false;
  bool _hasNumber = false;

  void _onChangePassword(String password) {
    var numReg = RegExp(r'[0-9]');
    setState(() {
      _isEightPassword = false;
      if (password.length >= 8) {
        _isEightPassword = true;
      }
      _hasNumber = false;
      if (numReg.hasMatch(password)) {
        _hasNumber = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Set a Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '하단의 제약사항에 따라 비번을 생성하시오',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (password) => _onChangePassword(password),
              obscureText: !_visible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: _visible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'input your password',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color:
                      _isEightPassword ? Colors.amber : Colors.transparent,
                      border: _isEightPassword
                          ? Border.all(color: Colors.amber)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('비번은 8글자 이상이어야 함')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _hasNumber ? Colors.amber : Colors.transparent,
                      border: _hasNumber
                          ? Border.all(color: Colors.amber)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('숫자 하나는 들어가야함')
              ],
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              height: 40,
              minWidth: double.infinity,
              onPressed: () {},
              child: Text('CREATE ACCOUNT'),
              color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
