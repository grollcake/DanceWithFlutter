import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/screens/intro_screen.dart';

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
// Done 드랍위치 가이드 블록 표시
// Done 상수 파일 분리
// Done Drop시 화면 흔들림
// Done 레벨 구현
// Done 레벨처리를 TTBlock 클래스 내부에 구현
// Done Drop을 연타하면 블록이 무한 재생성되는 문제 수정
// Done 게임시간 불일치 문제 (현재 레벨과 전체 진행시간 차이)
// Done 미리보기 블록 구현 방식을 column x row로 변경
// Done game end 블록 생성 시 기존 블록과 겹치는 문제 수정
// Done 제스처로 블록 이동
// Done 제스처 강도에 따른 블록 이동
// Done Intro 화면 구현
// Done 전체 레이아웃 다시 잡기
// Done 배경 이미지 추가
// Done 스와이프 동작의 반응성 개선
// Done SwipeDown을 연속으로 하는 경우 빠르게 불록이 나타났다 사라지는 현상 수정
// Done pause 구현
// todo 블록 회전 후 위치 조정 (기준점과의 거리를 계산으로 최적 위치 선정)
// todo 타일을 더 이쁘게 그리기 위해 별도 위젯(TTTile)으로 분리
// todo 블록 down, drop 시 트랜지션(애니메이션) 처리
// todo 스와이프 감도 설정 화면 구현 (미니 블록으로 직접 스와이핑 하면서 감도 설정)
// todo 효과음 추가
// todo 배경음악 추가
// todo 점수판 구현 (파이어스토어)
// todo 새로운 기록 갱신 시 push 알림

void main() => runApp(TetrisApp());

class TetrisApp extends StatelessWidget {
  const TetrisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyle.bgColor,
        primarySwatch: Colors.blueGrey,
      ),
      home: IntroScreen(),
    );
  }
}
