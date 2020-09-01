import 'package:another_calculator/buttons.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colorful calculator',
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> _buttons = ['C', 'DEL', '%', '/', '7', '8', '9', 'X', '4', '5', '6', '+', '1', '2', '3', '-', '0', '.', 'ANS', '='];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Colorful calculator')),
        backgroundColor: Colors.deepPurple[100],
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
                color: Colors.blue[200],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: GridView.builder(
                    itemCount: _buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (context, idx) {
                      Color btnColor, txtColor;
                      if (idx == 0) {
                        btnColor = Colors.green[400];
                        txtColor = Colors.white;
                      } else if (idx == 1) {
                        btnColor = Colors.red[400];
                        txtColor = Colors.white;
                      } else if (isOperator(_buttons[idx])) {
                        btnColor = Colors.deepPurple[400];
                        txtColor = Colors.white;
                      } else {
                        btnColor = Colors.deepPurple[50];
                        txtColor = Colors.black54;
                      }
                      return CalcButton(btnText: _buttons[idx], bgcolor: btnColor, color: txtColor, callBack: () {});
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  bool isOperator(String s) {
    if (['+', '-', 'X', '%', '/', '='].contains(s)) {
      return true;
    } else {
      return false;
    }
  }
}
