import 'dart:convert';
import 'dart:io';

import 'package:flutter_web_deplay/helpers/index_manipulate.dart';
import 'package:flutter_web_deplay/helpers/search_files.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

const BASE_HTML_FILE = 'public/base_index.html';
const SYMLINK_ROOT = 'public/projects';
const PROJECT_ROOT = 'D:\\flutter-dev\\DanceWithFlutter';

void main() async {
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

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

  print('Serving at http://${server.address.host}:${server.port}');
}

// Serve files from the file system.
final _staticHandler = shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

// Router instance to handler requests.
final _router = shelf_router.Router()
  ..get('/', _homepageHandler)
  ..get('/refresh', _homepageHandler);

Future<Response> _homepageHandler(Request request) async {
  print('Request for "${request.url}", "${request.context}", "${request.requestedUri}"');
  Map<String, Object> headers = {'Content-Type': 'text/html; charset=utf-8'};

  String url = '/' + request.url.toString();

  if (url == '/') {
    String html = await getIndexHtml();
    return Response.ok(html, headers: headers);
  } else if (url == '/refresh') {
    await rescanProjects();
    String html = await getIndexHtml();
    return Response.ok(html, headers: headers);
  }
}

void rescanProjects() async {
  // 0. 기존 링크 삭제
  Stream<FileSystemEntity> projecFiles = Directory(SYMLINK_ROOT).list(recursive: false, followLinks: false);

  await for (FileSystemEntity file in projecFiles) {
    FileSystemEntityType type = await FileSystemEntity.type(file.path);
    print('Checking ${file.path} > ${type.toString()}');
    if (type == FileSystemEntityType.link) {
      print('${file.path} is link. It will be deleted.'); // TODO
    }
  }

  // 1. index.html이 있는 프로젝트 검색
  List<String> indexFiles = await searchFiles(startPath: PROJECT_ROOT, searchFile: '\\build\\web\\index.html');

  // 2. 프로젝트명 확인
  List<String> projectNames = [];
  for (String indexFile in indexFiles) {
    String projectName = await extractProjectName(indexFile);
    projectNames.add(projectName);
  }

  // 2. 프로젝트명으로 index.html의 base href 변경
  for (int i = 0; i < indexFiles.length; i++) {
    await changeBaseHref(indexFiles[i], projectNames[i]);
  }

  // 3. symbolic link 생성
  for (int i = 0; i < indexFiles.length; i++) {
    String projectName = projectNames[i];
    String projectPath = path.dirname(path.dirname(path.dirname(indexFiles[i])));
    String symPath = SYMLINK_ROOT + Platform.pathSeparator + projectName;

    print('symlink $projectName: $projectPath');

    // TODO: symlink 생성 오류 수정 필요
    // Link symLink = await Link(projectPath).create(symPath);
    // print(symLink);
  }
}

Future<String> getIndexHtml() async {
  // 1. base html 읽어들이기
  String baseHtml = await File(BASE_HTML_FILE).readAsString();

  // 2. project 목록 확인
  Stream<FileSystemEntity> projectLink = Directory(SYMLINK_ROOT).list(recursive: false, followLinks: false);
  List<String> links = [];
  await for (FileSystemEntity link in projectLink) {
    if (await FileSystemEntity.type(link.path) != FileSystemEntityType.link) {
      // TODO: 여기 변경 필요
      links.add(path.basename(link.path));
    }
  }

  // 3. bootstrap list 생성
  List<String> listItems = [];
  for (String link in links) {
    listItems.add('<a href="/projects/$link" class="list-group-item list-group-item-action">$link</a>');
  }

  // 4. html 변경
  return baseHtml.replaceFirst('<PROJECT-LIST>', listItems.join('\n'));
}
