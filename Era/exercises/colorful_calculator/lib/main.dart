import 'package:colorful_calculator/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcurator',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator', style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepPurple),
      body: Calculator()
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final List<String> _btnTexts = ['C', 'DEL', '%', '/', '7', '8', '9', 'X', '4', '5', '6', '+', '1', '2', '3', '-', '0', '.', 'ANS', '='];
  bool isOperator(String s) {
    return ['+', '-', 'X', '%', '/', '='].contains(s);
  }

  GlobalKey _key = GlobalKey();

  String _q = '';
  String _a = '';
  double _buttonRatio = 1.0;
  
  _doCalc(String s) {
    if (s == '=') {
      final String query = _q.replaceAll('X', '*');
      Parser p = Parser();
      Expression exp = p.parse(query);
      ContextModel cm = ContextModel();
      double r = exp.evaluate(EvaluationType.REAL, cm);
      _a = r.toString();
      _q = '';
    }
    else if (s == 'C') {
      _q = '';
    }
    else if (s == 'DEL') {
      if (_q.length > 0 ) {
        _q = _q.substring(0, _q.length-1);
      }
    }
    else {
      _q += s;
    }
    setState(() {
      _a = _a;
      _q = _q;
    });
  }


  @override
  void initState() {
    print('initState');
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _adjustButtonRatio();
    });
    super.initState();
  }

  _adjustButtonRatio() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    var _size = renderBox.size;
    print("size is $_size");
    setState(() {
      _buttonRatio = _size.width /_size.height * 5 / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple[100],
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
//                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      alignment: Alignment.centerLeft,
                        child: Text(_q, style: TextStyle(fontSize: 24.0)),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.centerRight,
                        child: Text(_a, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                key: _key,
//                color: Colors.blue,
                child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      childAspectRatio: _buttonRatio
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String s = _btnTexts[index];
                      Color color, bgcolor;
                      if (index == 0) {
                        bgcolor = Colors.red;
                        color = Colors.white;
                      }
                      else if (index == 1) {
                        bgcolor = Colors.green;
                        color = Colors.white;
                      }
                      else if (isOperator(s)) {
                        bgcolor = Colors.deepPurple;
                        color = Colors.white;
                      }
                      else {
                        bgcolor = Colors.deepPurple[50];
                        color = Colors.deepPurple;
                      }

                      return CalcButton(text: s, color: color, bgcolor: bgcolor, callBack: () => _doCalc(s),);
                    }
                ),
              ),
            ),
          ],
        )
    );
  }
}