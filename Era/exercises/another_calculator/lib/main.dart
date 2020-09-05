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
  GlobalKey _keyButtonsContainer = GlobalKey();
  Size _buttonContainerSize;
  double _ratio = 1.0;

  final List<String> _buttons = ['C', 'DEL', '%', '/', '7', '8', '9', 'X', '4', '5', '6', '+', '1', '2', '3', '-', '0', '.', 'ANS', '='];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration duration){
      _getSizes();
    });
    super.initState();
  }

  _getSizes() {
    final RenderBox renderBox = _keyButtonsContainer.currentContext.findRenderObject();
    _buttonContainerSize = renderBox.size;
    print("Size of Button container is $_buttonContainerSize");
    setState(() {
      _ratio = _buttonContainerSize.width / _buttonContainerSize.height * (5/4);
      print(_ratio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Colorful calculator')),
        backgroundColor: Colors.deepPurple[100],
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('your input',
                            style: TextStyle(fontSize: 24, color: Colors.deepPurple[400]),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                        child: Text('Answer', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.deepPurple))),
                  ],
                )
              ),
              Expanded(
                flex: 2,
                child: Container(
                  key: _keyButtonsContainer,
//                  color: Colors.white,
//                  alignment: Alignment.bottomCenter,
                  child: GridView.builder(
                    itemCount: _buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: _ratio,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Color txtColor, bgColor;
                        if (index==0) {
                          txtColor = Colors.white;
                          bgColor = Colors.green;
                        }
                        else if (index == 1) {
                          txtColor = Colors.white;
                          bgColor = Colors.red;
                        }
                        else if (isOperator(_buttons[index])) {
                          txtColor = Colors.white;
                          bgColor = Colors.deepPurple;
                        }
                        else {
                          txtColor = Colors.deepPurple;
                          bgColor = Colors.deepPurple[50];
                        }
                        return CalcButton(
                          color: txtColor,
                          bgcolor: bgColor,
                          btnText: _buttons[index],
                          callBack: (){},
                        );
                      }
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
