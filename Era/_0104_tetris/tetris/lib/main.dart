import 'package:flutter/material.dart';
import 'package:tetris/screens/game_screen.dart';

// Done GameStart dialog 화면
// Done 가로크기를 11로 했을 때 블록 생성이 잘 못되는 문제 수정
// todo 전체 레이아웃 다시 잡기
// Done 점수 계산하기
// todo 제스처로 블록 이동
// Done Game End 처리
// todo 레벨 구현
// todo 블록 회전 후 위치 조정 (기준점과의 거리를 계산으로 최적 위치 선정)
// todo 타일을 그리는 것을 TTTile 위젯으로 추출
// Done Next 블록 표시
// Done Hold 기능 처리
// todo 확정위치 가이드 표시

void main() => runApp(TetrisApp());

class TetrisApp extends StatelessWidget {
  const TetrisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
