@ECHO OFF

REM Flutter web build

REM ~dp0는 현재 스크립트 파일의 폴더를 나타낸다.

set DART_FILE=%~dp0..\lib\Flutter-web-builder.dart
echo dart %DART_FILE%
dart %DART_FILE%
