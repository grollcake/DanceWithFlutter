import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _shapeIndex = 0;
  final List<List<List<int>>> _blockShapes = [
    // Block-I
    [
      [1],
      [1],
      [1],
      [1]
    ],
    // Block-J
    [
      [0,1],
      [0,1],
      [1,1],
    ],
    // Block-T
    [
      [1, 1, 1],
      [0, 1, 0]
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _blockShapes[_shapeIndex].length,
            (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _blockShapes[_shapeIndex][row].length,
                  (col) => Container(
                    margin: EdgeInsets.all(1),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _blockShapes[_shapeIndex][row][col] == 1 ? Colors.blue : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _shapeIndex = (_shapeIndex + 1) % _blockShapes.length;
              });
            },
            child: Text('Next'))
      ],
    );
  }
}
