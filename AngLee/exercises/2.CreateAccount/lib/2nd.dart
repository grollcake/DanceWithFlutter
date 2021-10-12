import 'package:flutter/material.dart';

void main() => runApp(const PasswordValidation());

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PASSWORD VALIDATION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _visible = false;
  bool _isEightNumber = false;
  bool _hasNumber = false;

  void _onChagePassword(String password) {
    setState(() {
      var regExp = RegExp(r'[0-9]');

      _isEightNumber = false;
      _hasNumber = false;

      if (password.length >= 8) {
        _isEightNumber = true;
      }

      if (regExp.hasMatch(password)) {
        _hasNumber = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '계정 만들기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0),
      body: Container(
        color: Colors.white38,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '비밀번호를 설정',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 14),
            Text(
              '아래 조건을 만족하는 강력한 비밀번호를 생성하세요',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: !_visible,
              onChanged: (password) => _onChagePassword(password),
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
                      borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(14)),
                  hintText: '비밀번호 설정',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: _isEightNumber ? Colors.green : Colors.transparent,
                      border: _isEightNumber
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white38,
                        size: 16,
                      )),
                ),
                SizedBox(width: 10),
                Text('비밀번호를 8자 이상으로 설정해주세요.')
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: _hasNumber ? Colors.green : Colors.transparent,
                      border: _hasNumber
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white38,
                        size: 16,
                      )),
                ),
                SizedBox(width: 10),
                Text('숫자 하나를 포함해 주세요.')
              ],
            ),
            SizedBox(height: 30,),
            MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              color: Colors.lime,
              child: Text('계정 생성', style: TextStyle(color: Colors.black, fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}
