/// Flutter webapp 버전을 github에 배포하기 위한 스크립트
/// 전제조건: 프로젝트명과 동일한 이름에 '_web' postfix가 붙은 저장소가 미리 준비되어 있어야 함
/// 실행조건1: 이 스크립트가 실행되는 디렉토리는 flutter 프로젝트 루트여야 함
/// 실행조건2: 현 프로젝트의 상위 폴더에 github-pages 폴더가 존재해야 함
/// 실행조건3: github-pages 아래에는 프로젝트명과 동일한 이름에 '_web' postfix가 붙은 폴더가 준비되어 있어야 함
/// 실행조건4: 조건3 폴더는 git remote url이 지정되어 있어야 함

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
    String githubProject = '';
    if (!await File('pubspec.yaml').exists() ||
        !await Directory('lib').exists() ||
        !await Directory('android').exists()) {
      throw ('It\'s not valid flutter project directory: $projectPath');
    } else {
      projectName = path.basename(Directory.current.path);
      githubProject = projectName + '_web';
    }

    // 2. 배포 디렉토리가 준비되었는지 확인
    // ../github-pages/{project}_web 디렉토리가 존재해야 함
    String deployDirectory = '../github-pages/$githubProject';
    if (!await Directory(deployDirectory).exists()) {
      throw ('Deploy directory does not exist: $deployDirectory');
    }

    // 3. flutter create .
    String winDeployDirectory = deployDirectory.replaceAll('/', r'\');

    var shell = Shell();

    await shell.run('''

      # Display dart version
      dart --version

      # Web skeleton file generate
      flutter create . --org appName

      # Web build
      flutter build web --base-href="/$githubProject/" --web-renderer canvaskit --release

      # Copy
      xcopy /e /y build\\web\\ $winDeployDirectory
    ''');

    // 작업 디렉토리 변경 후 후속작업 수행
    Directory.current = await Directory(deployDirectory);

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
