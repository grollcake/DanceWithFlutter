import 'package:calculator/widgets/build_result.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculator',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _query = '';
  double _result = 0.0;

  final List<String> _btnTexts = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    'ANS',
    '='
  ];

  void _calc(String btn) {
    print('$btn pressed');
    if (btn == 'C') {
      _query = '';
    } else if (btn == 'DEL') {
      if (_query.isNotEmpty) {
        _query = _query.substring(0, _query.length - 1);
      }
    } else if (btn == 'ANS') {
      // do nothing
    } else if (btn == '=') {
      // 결과 계산
      if (_query.isEmpty) {
        _result = 0.0;
      } else {
        String eval = _query;
        if (!_query.endsWith('=')) _query += '=';
        Parser p = Parser();
        Expression exp = p.parse(eval.replaceAll('X', '*'));
        // ContextModel cm = ContextModel();
        double r = exp.evaluate(EvaluationType.REAL, ContextModel());
        _result = r;
      }
    } else if (['%', '/', 'X', '+', '-'].contains(btn)) {
      if (_query.endsWith('=')) {
        _query = _result.toString() + btn;
      } else {
        _query += btn;
      }
    } else {
      if (_query.endsWith('=')) {
        _query = btn;
      } else {
        _query += btn;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _query,
                          style: TextStyle(fontFamily: 'AlarmClock', fontSize: 20, color: Colors.deepPurple),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple[50],
                        ),
                        child: BuildResult(result: _result),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: _btnTexts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return BuildCalcButton(btnText: _btnTexts[index], onPressed: _calc);
                    },
                  ),
                )
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(1),
                color: Colors.grey[50],
                child: Text(
                  'Amki Coding by Era, 20211005',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCalcButton extends StatelessWidget {
  const BuildCalcButton({
    Key? key,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  final String btnText;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    print(this.toString());

    isOperator(String s) => ['%', '/', 'X', '+', '-', '='].contains(s);

    Color bgColor = Colors.deepPurple[50]!;
    Color textColor = Colors.deepPurple;

    if (btnText == 'C') {
      bgColor = Colors.green;
      textColor = Colors.white;
    } else if (btnText == 'DEL') {
      bgColor = Colors.red;
      textColor = Colors.white;
    } else if (isOperator(btnText)) {
      bgColor = Colors.deepPurple;
      textColor = Colors.white;
    }

    return TextButton(
      onPressed: () => onPressed(btnText),
      style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 24, color: textColor),
      ),
    );
  }
}
