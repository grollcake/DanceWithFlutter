import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic tac toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const TicTacToeApp(),
    );
  }
}

class TicTacToeApp extends StatefulWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Tic Tac Toe'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final int PLAY_SIZE = 3;
  bool _isPlaying = false;
  String _message = '';
  late List<int> _plays;

  @override
  void initState() {
    super.initState();
    _plays = List.generate(PLAY_SIZE * PLAY_SIZE, (index) => 0);
    _message = '시작을 눌러주세요';
  }

  bool _isWon(int playerId) {
    for (int i = 0; i < PLAY_SIZE; i++) {
      // 1) 가로 완성 확인
      bool horizontalWon = true;
      for (int j = 0; j < PLAY_SIZE; j++) {
        int idx = i * PLAY_SIZE + j;
        if (_plays[idx] != playerId) {
          horizontalWon = false;
          break;
        }
      }
      if (horizontalWon) return true;

      // 2) 세로 완성 확인
      bool verticalWon = true;
      for (int j = 0; j < PLAY_SIZE; j++) {
        int idx = i + j * PLAY_SIZE;
        if (_plays[idx] != playerId) {
          verticalWon = false;
          break;
        }
      }
      if (verticalWon) return true;
    }

    // 3) 대각선 완성 확인1
    bool won1 = true;
    for (int i = 0; i < PLAY_SIZE; i++) {
      final idx = i + i * PLAY_SIZE;
      if (_plays[idx] != playerId) {
        won1 = false;
        break;
      }
    }
    if (won1) return true;

    // 4) 대각선 완성 확인2
    bool won2 = true;
    for (int i = 0; i < PLAY_SIZE; i++) {
      final idx = (PLAY_SIZE - 1 - i) * PLAY_SIZE + i;
      if (_plays[idx] != playerId) {
        won2 = false;
        break;
      }
    }
    if (won2) return true;

    return false;
  }

  aiPlay() {
    List<int> original = [..._plays];

    // 1) 내가 이길만한 위치 먼저 두기
    for (int i = 0; i < _plays.length; i++) {
      if (_plays[i] == 0) {
        _plays[i] = 2;
        if (_isWon(2)) {
          _message = 'AI가 이겼습니다.';
          _isPlaying = false;
          setState(() {});
          return;
        } else {
          _plays = [...original];
        }
      }
    }

    // 2) 상대가 이길만한 위치 막기
    for (int i = 0; i < _plays.length; i++) {
      if (_plays[i] == 0) {
        _plays[i] = 1;
        if (_isWon(1)) {
          _plays[i] = 2;
          _message = '당신의 차례입니다';
          setState(() {});
          return;
        } else {
          _plays = [...original];
        }
      }
    }

    // 3) 랜덤 위치에 두기
    List<int> candidate = [];
    for (int i = 0; i < _plays.length; i++) {
      if (_plays[i] == 0) candidate.add(i);
    }
    candidate.shuffle();
    _plays[candidate.first] = 2;
    _message = '당신의 차례입니다';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: GridView.builder(
              itemCount: PLAY_SIZE * PLAY_SIZE,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: PLAY_SIZE,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (_, index) {
                String label = _plays[index] == 0
                    ? ''
                    : _plays[index] == 1
                        ? 'O'
                        : 'X';

                return GestureDetector(
                  onTap: () {
                    if (!_isPlaying) return;
                    if (_plays[index] == 0) {
                      _plays[index] = 1;
                      if (_isWon(1)) {
                        _message = '당신이 이겼습니다.';
                        _isPlaying = false;
                      } else {
                        _message = 'AI의 차례입니다';
                      }
                      setState(() {});
                      if (!_isWon(1)) Timer(const Duration(milliseconds: 1000), aiPlay);
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(label,
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(_message),
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (!_isPlaying) {
                  setState(() {
                    _plays = List.filled(PLAY_SIZE * PLAY_SIZE, 0);
                    _isPlaying = true;
                    _message = '당신의 차례입니다.';
                  });
                }
              },
              child: Text(_isPlaying ? '게임중' : '시작'),
            ),
          ),
        ],
      ),
    );
  }
}
