import 'dart:convert';
import 'dart:io';

import 'helpers/index_manipulate.dart';
import 'helpers/search_files.dart';
import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

const INDEX_FILE = 'public/base_index.html';
const SYMLINK_ROOT = 'public/projects';
const PROJECT_ROOT = '/home/rollcake/DanceWithFlutter';
const AUTHORS = ['Era', 'AngLee', 'NewMiracle'];

void main() async {
  final port = int.parse(Platform.environment['PORT'] ?? '8888');

  // See https://pub.dev/documentation/shelf/latest/shelf/Cascade-class.html
  final cascade = Cascade()
      // First, serve files from the 'public' directory
      .add(_staticHandler)
      // If a corresponding file is not found, send requests to a `Router`
      .add(_router);

  // See https://pub.dev/documentation/shelf/latest/shelf_io/serve.html
  final server = await shelf_io.serve(
    // See https://pub.dev/documentation/shelf/latest/shelf/logRequests.html
    logRequests()
        // See https://pub.dev/documentation/shelf/latest/shelf/MiddlewareExtensions/addHandler.html
        .addHandler(cascade.handler),
    InternetAddress.anyIPv4, // Allows external connections
    port,
  );

  if (!await Directory(SYMLINK_ROOT).exists()) Directory(SYMLINK_ROOT).create();

  print('Serving at http://${server.address.host}:${server.port}');
}

// Serve files from the file system.
final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html', serveFilesOutsidePath: true);

// Router instance to handler requests.
final _router = shelf_router.Router()
  // ..get('/', _indexHandler)
  ..get('/refresh', _refreshHandler)
  ..get('/projects.json', _projectsHandler);

Future<Response> _indexHandler(Request request) async {
  // 1. base html 읽어들이기
  String index = await File(INDEX_FILE).readAsString();

  // 2. header 준비: 다른 사이트를 iframe으로 사용할 수 있도록 허용 목록을 전송한다.
  Map<String, Object> headers = {'Content-Type': 'text/html; charset=utf-8', 'Content-Security-Policy': 'script-src *'};

  // 3. 응답 처리
  return Response.ok(index, headers: headers);
}

Future<Response> _refreshHandler(Request request) async {
  await rescanProjects();

  Map<String, Object> headers = {'location': '/'};

  return Response(302, headers: headers);
}

Future<Response> _projectsHandler(Request request) async {
  Map<String, Object> headers = {'Content-Type': 'application/json'};

  List<Map<String, String>> projects = await getProjectsInfo();

  return Response.ok(jsonEncode(projects), headers: headers);
}

void rescanProjects() async {
  // 1. 최신 소스 가져오기 (git pull)
  var shell = Shell(workingDirectory: PROJECT_ROOT, throwOnError: false);
  await shell.run('''

    echo git pull
    git pull
  ''');

  // 1. 기존 링크 삭제
  Stream<FileSystemEntity> projecFiles = Directory(SYMLINK_ROOT).list(recursive: false, followLinks: false);

  await for (FileSystemEntity file in projecFiles) {
    FileSystemEntityType type = await FileSystemEntity.type(file.path);
    if (type == FileSystemEntityType.directory) {
      file.delete();
      // print('${file.path} is symlink and deleted.');
    }
  }

  // 2. index.html이 있는 프로젝트 검색
  List<String> indexFiles = await searchFiles(startPath: PROJECT_ROOT, searchFile: '/build/web/index.html');

  // 3. 프로젝트명 확인
  List<String> projectNames = [];
  for (String indexFile in indexFiles) {
    String projectName = await extractProjectName(indexFile);
    projectNames.add(projectName);
  }

  // 4. 프로젝트명으로 index.html의 base href 변경
  for (int i = 0; i < indexFiles.length; i++) {
    await changeBaseHref(indexFiles[i], '/projects/' + projectNames[i]);
  }

  // 5. symbolic link 생성
  for (int i = 0; i < indexFiles.length; i++) {
    String projectName = projectNames[i];
    String projectPath = path.dirname(indexFiles[i]);
    String symPath = SYMLINK_ROOT + Platform.pathSeparator + projectName;

    Link symLink = await Link(symPath).create(projectPath);
    print('symlink created: $projectName  >  $projectPath');
  }
}

// public/projects 아래에서 각 프로젝트별 build/web/으로 연결된 심볼릭 링크를 찾아서 반환한다.
Future<List<Map<String, String>>> getProjectsInfo() async {
  List<Map<String, String>> projects = [];

  // 1. projects symlink 경로(public/projects)에서 목록 확인
  Stream<FileSystemEntity> projectSymlinks = Directory(SYMLINK_ROOT).list(recursive: false, followLinks: false);

  await for (FileSystemEntity symlink in projectSymlinks) {
    // 2. 프로젝트 symlink 확인: symlink는 directory로 식별된다.
    if (await FileSystemEntity.type(symlink.path) == FileSystemEntityType.directory) {
      // 3. 프로젝트의 원래 절대경로 확인
      String realpath = await symlink.resolveSymbolicLinks();

      // 4. 프로젝트 이름 찾기
      String project = path.basename(symlink.path);

      // 5. 프로젝트의 원래 절대경로에서 저작자 이름 찾기
      String author = 'unknown';
      for (String candi in AUTHORS) {
        if (realpath.contains('/$candi/')) {
          author = candi;
          break;
        }
      }

      // 6. 미리보기 이미지 찾기
      // 절대경로가 <project>/build/web/을 가리키고 있기 때문에 두단계 위로 올라간 경로에서 탐색한다.
      String image = await findImageFromDirectory(path.dirname(path.dirname(realpath)));
      // /home/rollcake/DanceWithFlutter/Era/_1005_pacman/pacman.apng
      //  =>  https://github.com/grollcake/DanceWithFlutter/raw/master/Era/_1005_pacman/pacman.apng
      String imageUrl = image.replaceFirst(
          '/home/rollcake/DanceWithFlutter/', 'https://github.com/grollcake/DanceWithFlutter/raw/master/');

      // 7. github url 조립하기
      // [From real path]  /home/rollcake/DanceWithFlutter/Era/_1010_create_password/build/web
      // [To github url]  https://github.com/grollcake/DanceWithFlutter/tree/master/Era/_1010_create_password
      String githubUrl = realpath
          .replaceFirst(
              '/home/rollcake/DanceWithFlutter/', 'https://github.com/grollcake/DanceWithFlutter/tree/master/')
          .replaceFirst('/build/web', '');

      // 8. 결과 취합
      projects.add({'project': project, 'author': author, 'github': githubUrl, 'previewImage': imageUrl});
    }
  }

  // 프로젝트명으로 오름차순 정렬
  projects.sort((a, b) => a['project'].compareTo(b['project']));

  return projects;
}

Future<String> findImageFromDirectory(String dir) async {
  Stream<FileSystemEntity> files = Directory(dir).list(recursive: false, followLinks: false);

  await for (FileSystemEntity file in files) {
    if (file.path.endsWith('.png') || file.path.endsWith('.apng') || file.path.endsWith('.jpg')) {
      return file.path;
    }
  }

  return '';
}
