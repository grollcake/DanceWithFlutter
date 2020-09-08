import 'package:BeautyCalc_exam/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  String userQ = '';
  String userA = '';
  List buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', '*',
    '6','5','4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '='
  ];
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[200],
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.deepPurple[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQ, style: TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userA, style: TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),),
                  ),
                ],
              ),
            ), 
            ),
          Expanded(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
              itemBuilder: (BuildContext context, int index) {
                if(index == 0) {
                return(
                  MyButton(
                    ontapped: () {
                      setState(() {
                        userQ = '';
                      });
                    },
                    textColor: Colors.white,
                    color: Colors.green,
                    text: buttons[index]
                    )
                );

                } else if(index == 1) {
                return(
                  MyButton(
                    ontapped: () {
                      setState(() {
                        userQ = userQ.substring(0, userQ.length - 1);
                      });
                    },
                    textColor: Colors.white,
                    color: Colors.red,
                    text: buttons[index]
                    )
                );

                } else if(index == buttons.length-1) {
                return(
                  MyButton(
                    ontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    text: buttons[index]
                    )
                );

                } else {

                return(
                  MyButton(
                    ontapped: () {
                      setState(() {
                        userQ += buttons[index];
                      });
                    },
                    textColor: isOper(buttons[index]) ? Colors.white : Colors.deepPurple,
                    color: isOper(buttons[index]) ? Colors.deepPurple : Colors.white,
                    text: buttons[index]
                    )
                );
                }
              }
              ),
            flex: 2,
            ),
        ],
      ),
    );
  }

  bool isOper(String x) {
    if(x == '%' ||x == '/' ||x == '*' ||x == '-' ||x == '+' ||x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    final finalUserQ = userQ;

    Parser p = Parser();
    Expression exp = p.parse(finalUserQ);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    userA = result.toString();
  }
}