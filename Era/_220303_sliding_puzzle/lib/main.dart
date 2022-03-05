import 'package:flutter/material.dart';
import 'package:sliding_puzzle/sliding_puzzle_app.dart';

// Done elapsedTimer stream 초기 값을 00:00 으로 설정하기
// Done 조각 2개 이상을 한번에 이동시키기
// Done 조각 슬라이드 애니메이션에 커브 진행하기
// todo 게임상태 세분화: 대기, 시작중, 게임중, 완성
// todo 파워포인트로 기획서 만들기
// todo   - 슬라이딩 규칙에 대한 자세한 설명 필요
// todo (Epic) 게임 레이아웃 다시 잡기
// todo   - 상태별 제어버튼 재구성 (대기, 시작중, 게임중, 완성)
// Done   - 반응형으로 레이아웃 구성
// todo 게임 아이콘 만들기
// todo github 레포지토리 분리
// todo github pages에 배포
// todo 움직인 횟수 구현
// todo 배경 이미지 지정하기
// todo 게임 중지 시 alert dialog 띄우기
// todo (Epic) 게임 종료 후 share 기능 구현
// todo (Epic) 이미지 퍼즐 구현
// todo (Epic) 사용자 앨범 이미지로 퍼즐 구현
// todo (장기) riverpod로 교체

void main() {
  runApp(SlidingPuzzleApp());
}
