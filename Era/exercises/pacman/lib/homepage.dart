import 'package:flutter/material.dart';
import 'package:pacman/blocks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  final int numberOfSquares = numberInRow * 17;
  List<int> barriers = [0,1,2,3,4,5,6,7,8,9,10,11,22,33,44,55,66,77,88,99,110,121,132,143,154,165,176,177,178,179,180,181,182,183,184,185,186,21,32,43,54,65,76,87,98,109,120,131,142,153,164,175, 24, 35, 46, 57, 26, 28,30,32,37,38,39,41,52,63,78,79,80,81,70,59,61,72,83,84,85,86,100,101,102,103,105,106,107,108,114,116,123,125,127,129,134,140,145,147,148,149,151,156,158,160,162];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final Color color = barriers.contains(index) ? Colors.blue : Colors.black;
                    if (barriers.contains(index)) {
                      return WallBlock(text: index.toString());
                    }
                    else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Scores: ", style: TextStyle(color: Colors.white, fontSize: 40.0)),
                    Text("Start", style: TextStyle(color: Colors.white, fontSize: 40.0))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
