import 'package:flutter/material.dart';
import 'package:tetris/screens/game_screen.dart';

// Done GameStart dialog 화면
// Done 가로크기를 11로 했을 때 블록 생성이 잘 못되는 문제 수정
// Done 점수 계산하기
// Done Game End 처리
// Done Next 블록 표시
// Done Hold 기능 처리
// done 조작 버튼 간격 조정
// Done 블록 생성 통계 정보 표시
// Done 둥근 버튼의 횡 패딩 공간 최소화
// Done 같은 블록 연속으로 나오는것 방지
// Done Drop 기능
// Done HOLD Change는 블록당 한번만 가능
// Done 마지막 생성된 블록이 기존 블록을 겹치는 문제 (게임종료 조건에서..)
// Done Dialog에 흰색 테두리 추가
// todo 가이드 블록 표시
// todo Drop시 화면 흔들림
// todo 미리보기 블록 구현 방식 변경 column x row
// todo 블록 down, drop 시 트랜지션(애니메이션) 처리
// todo 블록 회전 후 위치 조정 (기준점과의 거리를 계산으로 최적 위치 선정)
// todo 타일을 그리는 것을 TTTile 위젯으로 분리
// todo 전체 레이아웃 다시 잡기
// todo 제스처로 블록 이동
// todo 레벨 구현

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
