# Flutter web server

flutter 프로젝트의 웹앱(`build/web/`)을 바로 실행해볼 수 있도록 목록을 보여주는 웹서버


## 1. 접속 주소

https://flutter.ifwind.net


## 2. 서버 실행

서버는 Era가 보유한 오라클 클라우드 무료서버에서 실행한다.

* 프로젝트 경로: `DanceWithFlutter/flutter-web-server`
* 프로젝트 준비: `bash prepare.sh`
* 서버 실행: 
  * 기본적으로 `systemd`에 등록되어 부팅 시 자동실행된다.
  * 수동 실행방법 #1: `sudo systemctl start flutter-web-server`
  * 수동 실행방법 #2: `bash run-server.sh`


## 3. URL Mapping

* `/`: public/index.html 파일 전송
* `/refresh`: 최신 소스로 업데이트(git pull) 후 web app들에 대해 public/projects에 symbolic link 생성
* `/projects.json`: public/projects에 있는 web app 목록을 json으로 반환


## 4. 기본 아키텍처

* 서버: Oracle 무료 서버 이용
* 웹서버: dart의 shelf 모듈 사용
* 도메인: flutter.ifwind.net
* 서비스 포트: 8888
* 도메인 > 포트매핑: Nginx Proxy Manager
* UI Framework: Bootstrap5 + Vue.js


## 5. 자동 갱신

github에서 제공하는 action 기능을 이용하여, 새로운 프로젝트가 push되면 flutter.ifwind.net도 프로젝트 목록이 자동갱신되도록 `wget https://flutter.ifwind.net/refresh`를 작업으로 추가함


## 6. 서버 자동실행 등록
systemd 서비스를 이용하여 자동 실행되도록 등록하였다.

서비스 파일 생성: `/etc/systemd/system/flutter-web-server.service`
```systemd
[Unit]
Description=flutter web server

[Service]
User=rollcake
Group=rollcake
WorkingDirectory=/home/rollcake/DanceWithFlutter/flutter-web-server
ExecStart=/home/rollcake/DanceWithFlutter/flutter-web-server/run-server.sh

[Install]
WantedBy=multi-user.target
```

서비스 등록 및 확인
```bash
sudo systemctl enable flutter-web-server
sudo systemctl start flutter-web-server.service
sudo systemctl status flutter-web-server.service
```


## 7. 프로젝트 세팅 준비 (최초 1회)

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


## 8. 개발관련 메모

### a. pubspec.yaml 생성

```yaml
name: flutter_web_server
version: "0.1.0"
description: flutter 프로젝트의 build/web을 자동으로 배포처리
homepage: https://flutter.ifwind.net
environment:
  sdk: '>=2.10.0 <3.0.0'
dependencies: 
  process_run: ^0.12.2+2
  shelf: ^1.2.0
  shelf_router: ^1.1.2
  shelf_static: ^1.1.0
dev_dependencies:
  test: '>=1.15.0 <2.0.0'
```


### b. 모듈 추가 및 가져오기 (예시)

```dart
dart pub add shelf
dart pub get
```