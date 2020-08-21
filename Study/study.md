# flutter 학습일지

## 2020-08-20: 개발환경 구성

### 환경 구성  요약

* https://flutter.dev/
* IDE: [Android Studio](https://developer.android.com/studio)를 기본 툴로 사용. [VSCode](https://code.visualstudio.com/download)도 사용할 수 있음.
* 디렉토리 구성

    | 디렉토리            | 용도                                                         | 비고                              |
    | ------------------- | ------------------------------------------------------------ | --------------------------------- |
    | D:\flutter-dev      | 기본 디렉토리                                                |                                   |
    | + downloads         | 각종 설치파일 다운로드 (Android Studio, SDK, git-scm 등)     |                                   |
    | + sdk / flutter     | flutter sdk 설치                                             |                                   |
    | + DanceWithFlutter  | 코드 저장소: https://github.com/grollcake/DanceWithFlutter.git |                                   |
    | ++ study            | 학습한 내용을 정리                                           |                                   |
    | ++ Era              | 김훈균 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
    | ++ NewMiracle       | 송준수 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
    | ++ DeveloperUnknown | 김경민 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
    |                     |                                                              |                                   |

* 설치할 프로그램

  | 프로그램명     | 용도                                      | 다운로드                               |
  | -------------- | ----------------------------------------- | -------------------------------------- |
  | git-scm        | Git, 소스코드 버전 관리, 원격 저장소 저장 | https://git-scm.com/downloads          |
  | Android Studio | flutter 통합 개발툴                       | https://developer.android.com/studio   |
  | VSCode         | 다재다능한 개발툴                         | https://code.visualstudio.com/download |
| Fork           | Git GUI 툴                                | https://git-fork.com/                  |
  | Typora         | 마크다운 에디터                           | https://typora.io/                     |
  | 뭔가 더 있어   |                                           |                                        |
  
  

### 구성 순서  (설치순서)

1. 디렉토리 생성: d:\flutter-dev
2. git 설치
3. DanceWithFlutter clone: git clone https://github.com/grollcake/DanceWithFlutter.git
4. flutter sdk 설치: https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.20.2-stable.zip  => d:\flutter-dev\sdk\flutter
5. Path 등록: d:\flutter-dev\sdk\flutter\bin
6. flutter doctor 실행해보기: cmd 창을 열고 `flutter doctor`
7. Android Studio 설치
   1. 최초 실행 시 flutter project 선택
   2. flutter sdk 위치 지정
   3. 프로젝트 위치는 DanceWithFlutter/<내이름> 지정
8. ADV 구성: 가상 안드로이드 에뮬레이터
   **Android Studio > Tools > Android > AVD Manager** 
9. (옵션) 에뮬레이터 가속 설정: https://developer.android.com/studio/run/emulator-acceleration
10. Android Studio 플러그인 설치: flutter Enhancement Suite (Pub package 설치 지원)

### 오늘의 숙제
* 환경 구성 마무리하고 샘플 App(카운터) 기동해보기
* 샘플 App을 포함한 DanceWithFlutter를 github에 push
* 코딩쉐프의 순한맛 강좌: https://www.youtube.com/playlist?list=PLQt_pzi-LLfpcRFhWMywTePfZ2aPapvyl




## 2020-08-21: flutter app 둘러보기

### Flutter로 만들어진 app 둘러보기

1. flutter clock app 확인
2. flutter showcase siet 확인 
   https://flutter.dev/showcase
3. flutter로 만들어진 Reflectly app 확인    
   
### 오늘의 숙제
* 코딩쉐프의 순한맛 강좌 완강: https://www.youtube.com/playlist?list=PLQt_pzi-LLfpcRFhWMywTePfZ2aPapvyl
* 코딩쉐프의 매운맛 강좌 완강:https://www.youtube.com/watch?v=StvbitxUKSo&list=PLQt_pzi-LLfoOpp3b-pnnLXgYpiFEftLB&index=1
* flutter sample app 직접 처음 부터 끝까지 코딩하기
  - sample app의 더하기 버튼 외에 마이너스 버튼만들기
  - 스스로 개발하면서 어려웠던점 8.24(월)에 서로 공유하기
  - 마이너스 버튼 추가한 app은 별도 폴더로 생성하여 올리기
    예시) D:\flutter-dev\DanceWithFlutter\NewMiracle\flutter_app_homework_0821
* flutter로 만들어 보고 싶은 앱 소개하기ㅈ
  