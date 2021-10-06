import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '0';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
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
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Calculator',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 12,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              userQuestion,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              userAnswer,
                              style: TextStyle(fontSize: 60),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 28,
              child: Container(
                color: Colors.grey[300],
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CalBtn(
                        color: Colors.green,
                        textColor: Colors.white,
                        text: buttons[index],
                        tabEvent: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '0';
                          });
                        },
                      );
                    } else if (index == 1) {
                      return CalBtn(
                        color: Colors.pink,
                        textColor: Colors.white,
                        text: buttons[index],
                        tabEvent: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                      );
                    } else if (index == buttons.length - 1) {
                      return CalBtn(
                        color: Colors.teal[600],
                        textColor: Colors.white,
                        text: buttons[index],
                        tabEvent: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                      );
                    } else {
                      return CalBtn(
                        color: isOperator(buttons[index])
                            ? Colors.teal[600]
                            : Colors.grey[600],
                        textColor: Colors.white,
                        text: buttons[index],
                        tabEvent: () {
                          setState(() {
                            if (isOperator(buttons[index]) && userQuestion == '') {
                              userQuestion = userAnswer + buttons[index];
                            } else {
                              userQuestion += buttons[index];
                            }
                          });
                        },
                      );
                    }
                  },
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.teal,
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
    userQuestion = '';
  }

  bool isInt(String str) {
    if (str == null) {
      return false;
    }
    return int.tryParse(str) != null;
  }

  bool isDouble(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}

class CalBtn extends StatelessWidget {
  const CalBtn(
      {Key? key, this.color, this.textColor, required this.text, this.tabEvent})
      : super(key: key);

  final color;
  final textColor;
  final String text;
  final tabEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: tabEvent,
        child: ClipRRect(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
