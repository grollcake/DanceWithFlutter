import 'package:flutter/material.dart';
import 'dart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Game',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.redAccent,
        ),
        body: Builder(builder: (context) {
          return GestureDetector(onTap: () {
            FocusScope.of(context).unfocus();
          }
          ,child : SingleChildScrollView(
                child : Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top : 50),),
                    Center(child : Image.asset('image/chef.gif')),
                    Form(
                      child : Container(
                        padding: EdgeInsets.all(30.0),
                        child : Column(
                          children: [
                            TextField(
                              controller: controller,
                              decoration: InputDecoration(labelText: 'input dice'),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextField(
                              controller: controller2,
                              decoration: InputDecoration(labelText: 'input PW'),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            SizedBox(height: 40.0),
                            ButtonTheme(
                              minWidth: 100.0,
                              height : 40.0,
                                child : RaisedButton(
                                    child : Icon(Icons.arrow_forward),
                                    color: Colors.white,
                                    onPressed: (){
                                      if(controller.text == 'dice' && controller2.text == '1234'){
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> Dice()));
                                      }else{
                                        showSnackBar(context);
                                      }
                                      }
                                    )
                            )
                          ],
                        )
                      )
                    )
                  ],
                )
              )
          );
        }));
  }
}

void showSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('로그인 정보를 확인하세요'), duration: Duration(seconds: 2), backgroundColor: Colors.blue));
}