import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';

class FlutterWebBuilder {
  final String projectPath;

  FlutterWebBuilder({this.projectPath = '.'});

  void webBuild() async {
    // 0. 프로젝트 디렉토리 유효성 확인
    if (!await Directory(projectPath).exists()) {
      throw ('Project path does not exist: $projectPath');
    } else {
      Directory.current = await Directory(projectPath);
    }

    print('Working direcotry: ${Directory.current.path}');

    // 1. 유효한 프로젝트인지 확인
    // pubspec.yaml, lib/, android/ 파일이 존재하면 유효한 프로젝트
    String projectName = '';
    if (!await File('pubspec.yaml').exists() ||
        !await Directory('lib').exists() ||
        !await Directory('android').exists()) {
      throw ('It\'s not valid flutter project directory: $projectPath');
    } else {
      projectName = path.basename(Directory.current.path);
    }

    // 2. .gitignore에 build 경로 제외를 주석처리
    if (await changeGitIgnore('.gitignore')) {
      print('.gitignore changed!');
    }

    // 3. flutter create .
    var shell = Shell();

    await shell.run('''

      # Display dart version
      dart --version

      # Web skeleton file generate
      flutter create .

      # Web build
      flutter build web --base-href="/projects/$projectName/"

      # git add
      git add build/web/*
      git add web/*

      echo All done!
    ''');
  }

  // 프로젝트 디렉토리의 .gitignore 파일을 수정해서 build/web 경로가 추적될 수 있도록 한다.
  // DanceWithFlutter 저정소의 메인 .gitignore에서 build/web을 추적하도록 이미 설정했기 때문에,
  // 개별 프로젝트에서는 build를 주석처리하기만 하면 된다.
  Future<bool> changeGitIgnore(String filepath) async {
    // 파일이 없으면 종료
    if (!await File(filepath).exists()) {
      print('File is not exist: $filepath');
      return false;
    }

    // .gitignore 파일을 읽어들인다.
    var contents = await new File(filepath).readAsString();

    String newContents = contents.replaceFirst(RegExp(r'^/build/$', multiLine: true), '# /build/');

    if (newContents != contents) {
      await new File(filepath).writeAsString(newContents);
      return true;
    } else {
      return false;
    }
  }
}

// main() => FlutterWebBuilder(projectPath: 'D:/flutter-dev/DanceWithFlutter/Era/_1010_create_password').webBuild();
main() => FlutterWebBuilder().webBuild();
