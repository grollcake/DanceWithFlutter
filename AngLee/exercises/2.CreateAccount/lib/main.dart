import 'package:flutter/material.dart';

void main() => runApp(const PasswordValidation());

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Validation',
      theme: ThemeData(primarySwatch: Colors.brown),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isVisible = false;

  bool _isEightNumber = false;
  bool _hasOneNumber = false;
  bool _hasOneUpperCase = false;

  void _validationPassword(String password) {
    setState(() {
      var regExp = RegExp(r'[0-9]');
      var regUpper = RegExp(r'[A-Z]');

      _isEightNumber = false;
      _hasOneNumber = false;
      _hasOneUpperCase = false;

      if (password.length >= 8) {
        _isEightNumber = true;
      }

      if (regExp.hasMatch(password)) {
        _hasOneNumber = true;
      }

      if (regUpper.hasMatch(password)) {
        _hasOneUpperCase = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          title: Center(child: Text('Create Account')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '비밀번호 설정하기',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '아래 조건에 만족하는 강력한 비밀번호를 생성하세요.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (password) => _validationPassword(password),
              obscureText: !_isVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: '비밀번호 입력'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                AnimatedContainer(
                  width: 24,
                  height: 24,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      color: _isEightNumber ? Colors.brown : Colors.transparent,
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '비밀번호를 8자 이상으로 설정해주세요.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AnimatedContainer(
                  width: 24,
                  height: 24,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      color: _hasOneNumber ? Colors.brown : Colors.transparent,
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '숫자 하나를 포함시켜 주세요',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AnimatedContainer(
                  width: 24,
                  height: 24,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      color:
                          _hasOneUpperCase ? Colors.brown : Colors.transparent,
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '대문자 하나를 포함시켜 주세요.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Colors.brown,
              child: Text(
                '계정 생성',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
