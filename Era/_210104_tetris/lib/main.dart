import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/screens/intro/intro_screen.dart';

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
// Done 뒤로가기 버튼 비활성화
// Done 앱 아이콘 제작
// Done (오류수정) Hold 후 그림자 블록이 예전 모양으로 잠시 나타나는 문제 수정
// Done (개선) 스와이프 반응성 개선
// Done App에 github 연결 아이콘 추가
// Done (설정화면) 컬러테마 선택
// Done (설정화면) 블록모양 선택
// Done (설정화면) 배경이미지 선택
// Done (설정화면) github 연결 페이지
// Done 타일을 더 이쁘게 그리기 위해 별도 위젯(TTTile)으로 분리
// Done 설정 내용을 기기에 저장
// Done (설정화면) 가이드라인, 그림자 블록
// Done 효과음 추가 - 일단 소리는 난다
// Done 마지막으로 봤던 설정화면 유지
// Done 배경음악 추가
// todo 배경음악 변경
// todo 효과음 추가 - clearning, hold, game-end, level-up
// todo (설정화면) About - 나의 프로파일, github 연결, 이미지/사운드 credit 노출
// todo 타일 디자인 새로하기
// todo 점수판 구현 (파이어스토어)
// todo 피드백 보내기 기능
// todo (설정화면) 조작방법 설명
// todo (설정화면) 스와이프 감도 설정 화면 구현 (미니 블록으로 직접 스와이핑 하면서 감도 설정)
// todo 블록 회전 후 위치 조정 (기준점과의 거리를 계산으로 최적 위치 선정)
// todo 새로운 기록 갱신 시 push 알림

void main() async {
  return runApp(TetrisApp());
}

class TetrisApp extends StatelessWidget {
  const TetrisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSettings.loadSettings(); // 설정 정보 읽어오기
    return MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyle.bgColor,
      ),
      home: IntroScreen(),
    );
  }
}
