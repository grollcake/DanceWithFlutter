/// Flutter webapp 버전을 github에 배포하기 위한 스크립트
/// 배포위치: github.com/grollcake/flutter-webapp
/// 실행조건1: 이 스크립트가 실행되는 디렉토리는 flutter 프로젝트 루트여야 함
/// 실행조건2: 현 프로젝트의 상위 폴더에 flutter-webapp 폴더가 존재해야 함

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';

class GithubWebDeploy {
  final String projectPath;

  GithubWebDeploy({this.projectPath = '.'});

  void buildAndDeploy() async {
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

    // 2. 배포 디렉토리가 준비되었는지 확인
    // ../flutter-webapp 디렉토리가 존재해야 함
    String webappDirectory = '../flutter-webapp';
    if (!await Directory(webappDirectory).exists()) {
      throw ('Deploy directory does not exist: $webappDirectory');
    }

    // 3. flutter web build and copy to flutter-webapp
    String copyToDirectory = webappDirectory.replaceAll('/', r'\') + '\\$projectName';

    var shell = Shell();

    await shell.run('''

      # Display dart version
      dart --version

      # Web skeleton file generate
      flutter create . --org appName

      # Web build
      flutter build web --base-href="/flutter-webapp/$projectName/" --web-renderer canvaskit --release

      # Copy
      xcopy /e /y /i build\\web\\ $copyToDirectory
    ''');

    // 작업 디렉토리 변경 후 후속작업 수행
    Directory.current = await Directory(webappDirectory);

    await shell.run('''

      # git add & push
      git add *
      git commit -m "update webapp"
      git push

      echo All done!
    ''');
  }
}

// main() => FlutterWebBuilder(projectPath: 'D:/flutter-dev/DanceWithFlutter/Era/_1010_create_password').webBuild();
main() => GithubWebDeploy().buildAndDeploy();
