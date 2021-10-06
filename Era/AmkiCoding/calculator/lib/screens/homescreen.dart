import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  _CalcScreenState createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0XFFC9B9E5),
      body: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: const BuildResultArea(expression: '3+4', result: 7.0),
            ),
            Container(
              color: Colors.transparent,
              // height: 400,
              child: BuildButtonsArea(),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   color: Colors.black87,
            // )
          ],
        ),
      ),
    );
  }
}

class BuildResultArea extends StatelessWidget {
  const BuildResultArea({Key? key, required this.expression, required this.result}) : super(key: key);

  final String expression;
  final double result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          width: double.infinity,
          height: 70,
          color: Colors.transparent,
          child: Text(expression, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple[200],
          ),
          width: double.infinity,
          height: 70,
          child: Text(
            result.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class BuildButtonsArea extends StatelessWidget {
  BuildButtonsArea({Key? key}) : super(key: key);

  final List<String> _operators = ['+', '-', '/', 'X', '=', '%'];

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

  List<Color> _getColor(String label) {
    List<Color> buttonColor = [];

    if (label == 'C') {
      buttonColor.add(Colors.green);
      buttonColor.add(Colors.white);
    } else if (label == 'DEL') {
      buttonColor.add(Colors.red);
      buttonColor.add(Colors.white);
    } else if (_operators.contains(label)) {
      buttonColor.add(Colors.deepPurple);
      buttonColor.add(Colors.white);
    } else {
      buttonColor.add(Colors.white);
      buttonColor.add(Colors.deepPurple);
    }

    return buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _buttons.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String label = _buttons[index];
        List<Color> _colors = _getColor(label);

        return TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              backgroundColor: _colors[0],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
          child: Text(label, style: TextStyle(fontSize: 16, color: _colors[1], fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
