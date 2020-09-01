import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext c) {
    return MaterialApp(
      title: "Calc App",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.red,
      ),
      home : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _string = "";
  String _result = "";
  bool lastCalc = false;
  void _clickButton(String buttonValue) {
    _buttonPressedAction(buttonValue);
    _setResult();
  }
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calc App"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            Text("$_string", 
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              width: 50
                            )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("$_result", 
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey
                              ),
                            ),
                            SizedBox(
                              width: 50
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: _createButtonPad(),
            ),
          ],
        ),
      ),
    );
  }


  Widget _createButtonPad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("AC", 1),
              _createButton("/", 1),
              _createButton("*", 1),
              _createButton("C", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("1", 1),
              _createButton("2", 1),
              _createButton("3", 1),
              _createButton("+", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("4", 1),
              _createButton("5", 1),
              _createButton("6", 1),
              _createButton("-", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("7", 1),
              _createButton("8", 1),
              _createButton("9", 1),
              _createButton("%", 1),
            ],
          )
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createButton("0", 2),
              _createButton("00", 1),
              _createButton("=", 1),
            ],
          )
        ),
      ],
    );
  }

  Widget _createButton(String buttonValue, int flex) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        child: Text("$buttonValue",
          style: TextStyle(
            fontSize: 20
          ),
        ),
        onPressed: () => _clickButton(buttonValue),
      ),
    );
  }

  void _buttonPressedAction(String buttonValue) {
    setState(() {
      if(buttonValue == "AC") {
        _string = "";
      } else if(buttonValue == "/" || buttonValue == "*" || buttonValue == "+" || buttonValue == "-" || buttonValue == "%") {
        if(_string.length == 0 ) {
          return;
        } else if(lastCalc) {
          _string = _string.substring(0, _string.length-1) + buttonValue;
        } else {
          _string += buttonValue;
          lastCalc = true;
        }
      } else if(buttonValue == "C") {
        if(buttonValue.length == 0) return;
        _string = _string.substring(0, _string.length-1);
      } else if(buttonValue == "=") {
        _string = _result;
      } else {
        _string += buttonValue;
        lastCalc = false;
      }
    });
  }

  void _setResult() {
    try {
        String last_char = _string.substring(_string.length-1, _string.length);
        int.parse(_string.substring(_string.length-1, _string.length));
        int i = 0;
        List<String> calcList = _string.splitMapJoin((new RegExp(r'[^0-9]')), onMatch: (m) => '*').split("*");
        List<String> operList = List<String>();
        int operidx = 0;
        while(i < _string.length) {
          if(_string[i] == "/" || _string[i] == "*" || _string[i] == "+" || _string[i] == "-" || _string[i] == "%") {
            operList.add(_string[i]);
          }
          i++;
        }
        i = 0;
        int result = 0;
        if(calcList.length == 1) {
          result = int.parse(calcList[0]);
        } else {
          while(i < calcList.length - 1) {
            if(i == 0) {
              result = _calc(int.parse(calcList[i]), int.parse(calcList[i+1]), operList[i]);
            } else {
              result = _calc(result, int.parse(calcList[i+1]), operList[i]);
            }
            i++;
          }
        }
        setState(() {
          _result = result.toString();
        });
    } catch(e) {
      setState(() {
        _result = "";
      });
    }
  }
}

int _calc(int n1, int n2, String oper) {
  print("$n1 $oper $n2");
  if(oper == "+") return n1 + n2;
  else if(oper == "-") return n1 - n2;
  else if(oper == "/") return (n1 / n2).round();
  else if(oper == "*") return n1 * n2;
  else if(oper == "%") return n1 % n2;
}