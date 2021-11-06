# Flutter web server
flutter 프로젝트의 웹앱(`build/web/`)을 바로 실행해볼 수 있도록 목록을 보여주는 웹서버

## 기본 아키텍처
* 서버: Oracle 무료 서버 이용
* 웹서버: dart의 shelf 모듈 사용
* 도메인: flutter.ifwind.net
* 서비스 포트: 8888
* Frontend: Bootstrap5

## 서버 실행
* 프로젝트 경로: `DanceWithFlutter/flutter-web-server`
* 프로젝트 준비: `bash prepare.sh`
* 서버 실행: `bash run-server.sh`

## 프로젝트 세팅 준비 (최초 1회)
### a. 우분투 서버에 dart 설치
[공식 설치 가이드](https://dart.dev/get-dart)
```bash
 sudo apt-get update
 sudo apt-get install apt-transport-https
 sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
 sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
 sudo apt-get update
 sudo apt-get install dart
```

## 개발관련 메모
### a. pubspec.yaml 생성
```yaml
name: flutter_web_server
version: "0.1.0"
description: flutter 프로젝트의 build/web을 자동으로 배포처리
homepage: https://flutter.ifwind.net
environment:
  sdk: '>=2.10.0 <3.0.0'
dependencies: 
dev_dependencies:
  test: '>=1.15.0 <2.0.0'
```
### b. 모듈 추가 및 가져오기
```dart
dart pub add shelf
dart pub get
```