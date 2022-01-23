# Tetris

단순한 테트리스 앱

* 인트로 화면
* 스와이프로 블록이동, 회전, Drop 처리
* 한 줄 Clear 효과
* 그림자 블록 표시
* 블록 아껴두기 (Hold)
* 다음 블록 미리보기 (Next)
* 레벨, 점수, 시간 구현
* 게임 일시 중지



## Preview
 ![preview](preview.png)



## Packages

* animate_do: 인트로 화면에서 블록이 시간차를 두고 나타나는 효과 구현에 사용

* font_awesome_flutter: 게임화면의 아이콘

* pausable_timer: 일시중지 가능한 타이머

  

## Lessons learned
* 애니메이션 개념 및 구현방법 확실히 학습!

* 앱 아이콘 변경

* AppBar가 없을 때 Gridview.builder 사용 시 상단 고정 Padding 생기는 것 방지하는 방법

  ```dart
  MediaQuery.removePadding(
       removeTop: true,
       context: context,
       child: GridView.builder()
  ```

* 반투명한 다이얼로그 생성 방법

* 안드로이드 뒤로가기 버튼 비활성화

  ```dart
  WillPopScope(
    onWillPop: () async => false,
    child: Scaffold()
  ```