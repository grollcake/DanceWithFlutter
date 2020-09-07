import 'package:amki_coding_calc/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Calculator'),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: CalculatorApp()),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final List<String> _buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];
  String _q = '';
  String _a = '';
  double _btnRatio = 1.0;
  GlobalKey _key = GlobalKey();

  _doCalc(String s) {
    if (s =='=') {
      final String qq = _q.replaceAll('X', '*');
      Parser parser = Parser();
      Expression exp = parser.parse(qq);
      ContextModel cm = ContextModel();
      double ans = exp.evaluate(EvaluationType.REAL, cm);
      _a = ans.toString();
      _q = '';
    }
    else if (s=='DEL') {
      if (_q.length>0) {
        _q = _q.substring(0, _q.length-1);
      }
    }
    else if (s == 'C') {
      _q= '';
    }
    else {
      _q += s;
    }

    setState(() {
      _q = _q;
      _a = _a;
    });
  }

  _calcButtonRatio() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    final Size btnContainerSize = renderBox.size;
    setState(() {
      _btnRatio = btnContainerSize.width / btnContainerSize.height * 5 / 4;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _calcButtonRatio();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.deepPurple[50],
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              // color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(_q, style: TextStyle(fontSize: 24.0, color: Colors.grey[800])),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(_a,
                        style: TextStyle(fontSize: 32.0, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              key: _key,
              color: Colors.teal,
              child: GridView.builder(
                  itemCount: _buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    childAspectRatio: _btnRatio
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String s = _buttons[index];
                    Color color, bgcolor;
                    if (index == 0) {
                      color = Colors.white;
                      bgcolor = Colors.green;
                    } else if (index == 1) {
                      color = Colors.white;
                      bgcolor = Colors.red;
                    } else if ('%/X-+='.contains(s)) {
                      color = Colors.white;
                      bgcolor = Colors.deepPurple;
                    }
                    else {
                      color = Colors.deepPurple;
                      bgcolor = Colors.deepPurple[100];
                    }

                    return CalcButton(text: s, color: color, bgcolor: bgcolor, callback: () => _doCalc(s));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
