import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_puzzle/sliding_puzzle_app.dart';

// Done elapsedTimer stream 초기 값을 00:00 으로 설정하기
// Done 조각 2개 이상을 한번에 이동시키기
// Done 조각 슬라이드 애니메이션에 커브 진행하기
// Done 게임 레이아웃 다시 잡기 (약 50% 진행)
// Done 움직인 횟수 구현
// Done 앱 색상테마 기본값 지정
// Done 경과시간을 나태내는 스트림빌더에서 발생하던 'Bad state: Stream has already been listened to' 오류 해결
//       => StreamController를 적정 시점에 재생성하는 방법 사용
// Done playing 상태에서만 슬라이딩이 가능하도록 제한
// Done 게임상태 세분화: 대기, 시작중, 게임중, 완성
// Done 게임 시작 시 3,2,1,Go 카운트 다운 구현
// Done 상단에 lottie 애니메이션 추가
// Done 이미지로 조각만들기
// Done (오류) completed 일 때 시간이 초기화됨
// Done 기본 기능 완료
// Done 가로 회전이 안되게 조치
// Done 디바이스 높이가 너무 낮은 경우 오류 아이콘 표시
// todo 사운드 추가
// todo 컬러 테마 재설정
// todo 파워포인트로 기획서 만들기
// todo   - 슬라이딩 규칙에 대한 자세한 설명 필요
// Done (Epic) 게임 레이아웃 다시 잡기
// Done   - 상태별 제어버튼 재구성 (대기, 시작중, 게임중, 완성)
// Done   - 반응형으로 레이아웃 구성
// todo 게임 아이콘 만들기
// todo github 레포지토리 분리
// todo github pages에 배포
// todo 배경 이미지 지정하기
// todo 게임 중지 시 alert dialog 띄우기
// todo (Epic) 게임 종료 후 share 기능 구현
// todo (Epic) 이미지 퍼즐 구현
// todo (Epic) 사용자 앨범 이미지로 퍼즐 구현
// todo (장기) riverpod로 교체

void main() {
  // 디바이스 세로 모드만 가능토록 지정
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // 앱 시작
  runApp(SlidingPuzzleApp());
}
