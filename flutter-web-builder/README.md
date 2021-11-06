# Flutter web builder

명령어 한개(`flutter-web-build`)로 웹에서 실행되는 flutter 앱을 생성한다.

## 1. 사전 준비 (1회성 작업)

1. `dart pub get`으로 관련 패키지 다운로드

2. `bin` 폴더를 시스템 PATH에 등록 (고급 시스템 설정 메뉴)

## 2. 실행 방법

1. 웹 버전을 생성할 프로젝트 루트에서 cmd 창을 연다.

2. `flutter-web-build`를 실행한다. 약 2~3분 소요.

3. `build/web` 폴더를 확인하면 index.html외 관련 파일이 생성되어 있다.

## 3. 작동 원리

`flutter-web-build`가 내부적으로 어떤 작업을 하는지 설명한다.
* 현재 작업 디렉토리가 유효한 flutter 프로젝트인지 확인한다.
* 생성된 결과물(`build/web/*`)이 버전관리에 추가될수 있도록 `.gitignore`에서 `/build/`를 미리 주석처리해둔다.
* flutter web 버전을 생성한다.
    ```
    flutter create .
    flutter build web
    ```
* 결과물을 버전관리에 추가한다. `git add build/web/*`
