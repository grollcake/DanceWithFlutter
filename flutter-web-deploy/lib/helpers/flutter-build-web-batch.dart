import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';

class FlutterBuildWebBatch {
  static final FLUTTER_PROJECT_DIR = '/home/rollcake/DanceWithFlutter';
  static final EXCLUDE_PATHS = ['/Era/exercises/', 'NewMiracle/Practice/', '/DeveloperUnknown/'];

  Future<void> gitPull() async {
    // git pull
    var result = await Process.run('git', ['pull']);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }

  void buildNew() async {
    List<String> newProjects = [];

    // 1. 프로젝트 디렉토리 탐색: pubspec.yaml, lib/, android/가 존재하면 flutter project 디렉토리이다.
    // 2. build/web/index.html이 존재하면 이미 빌드된 프로젝트이므로 skip한다.
    Stream<FileSystemEntity> entityList = Directory(FLUTTER_PROJECT_DIR).list(recursive: true, followLinks: false);

    await for (FileSystemEntity entity in entityList) {
      // 무시할 경로에 포함됐는지 확인
      var checked = EXCLUDE_PATHS.where((exclude_path) => entity.path.indexOf(exclude_path) > 0);
      if (checked.length > 0) {
        // print('EXCLUDE PATH: ${entity.path}');
        continue;
      }

      if (entity.path.endsWith('/pubspec.yaml')) {
        String dir = path.dirname(entity.path);
        if (await Directory('$dir/lib').exists() && await Directory('$dir/android').exists()) {
          if (!await File('$dir/build/web/index.html').exists()) {
            print('NEW PROJECT: $dir');
            newProjects.add(dir);
          }
        }
      }
    }

    // 3. build web 작업을 순차 실행한다.
    // 3-1. flutter pub get
    // 3-2. flutter create .
    // 3-3. flutter build web
    for (String dir in newProjects) {
      var shell = Shell(workingDirectory: dir, throwOnError: false);
      await shell.run('''
      echo Working on $dir
      flutter pub get
      flutter create .
      echo flutter build web
      ''');
    }
  }
}

main() async {
  await FlutterBuildWebBatch().buildNew();
}
