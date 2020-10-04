import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: Login(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.red,
      ),
    );
  }
}

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController ctr1 = TextEditingController();
  TextEditingController ctr2 = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login page"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {},),
        ]
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:50)),
                  Center(
                    child: Image(
                      image: AssetImage('images/dise6.png'),
                      width: 170.0,
                      height: 170.0,
                    ),
                  ),
                  Form(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0)
                        )
                      ),
                      child: Container(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: ctr1,
                              decoration: InputDecoration(labelText: 'Enter asdf'),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextField(
                              controller: ctr2,
                              decoration: InputDecoration(labelText: 'Enter asdf'),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: RaisedButton(
                                color: Colors.orangeAccent,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  )
                ],
              )
            ),
          );
        }, 
      )
    );
  }
}