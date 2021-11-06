# Flutter web builder

단 한번의 명령어(`flutter-web-build`)로 flutter web app을 빌드한다.

(주의) 웹서버로 배포까지 해주지는 않는다!

## 1. 사전 준비 (1회성 작업)

1. `dart pub get`으로 관련 패키지 다운로드

2. `flutter-web-build.bat` 파일이 있는 `bin` 폴더를 시스템 PATH에 등록 (윈도우의 고급 시스템 설정 메뉴)

## 2. 실행 방법

1. cmd 창을 열엇 web app을 빌드할 프로젝트 경로로 이동한다.

2. `flutter-web-build`를 실행한다. 약 2~3분 소요.

3. `build/web` 폴더에 web app용 파일(index.html 등)이 생성된 걸 확인할 수 있다.

## 3. 작동 원리

`flutter-web-build`는 다음의 작업을 수행한다.
* 현재 작업 디렉토리가 유효한 flutter 프로젝트인지 확인한다.
* `.gitignore`에서 `/build/`를 미리 주석처리한다. (빌드된 결과물이 버전관리에 포함될 수 있도록 미리 조치)
* flutter web app build 명령어 실행
    ```
    flutter create .
    flutter build web
    ```
* web app을 버전관리에 추가: `git add build/web/*`
