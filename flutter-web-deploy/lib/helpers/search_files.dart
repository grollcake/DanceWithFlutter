import 'dart:io';

Future<List<String>> searchFiles({String startPath, String searchFile}) async {
  List<String> searchResult = [];

  Stream<FileSystemEntity> entityList = Directory(startPath).list(recursive: true, followLinks: false);

  await for (FileSystemEntity entity in entityList) {
    entity.path.endsWith(searchFile) ? searchResult.add(entity.path) : false;

    // FileSystemEntityType type = await FileSystemEntity.type(entity.path);
    // String label;
    // switch (type) {
    //   case FileSystemEntityType.directory:
    //     label = 'D';
    //     break;
    //   case FileSystemEntityType.file:
    //     label = 'F';
    //     break;
    //   case FileSystemEntityType.link:
    //     label = 'L';
    //     break;
    //   default:
    //     label = 'UNKNOWN';
    // }
    // print('$label: ${entity.path}');
  }

  return searchResult;
}

void main() {
  searchFiles(startPath: 'D:\\flutter-dev\\DanceWithFlutter', searchFile: '\\build\\web\\index.html').then((results) {
    results.forEach((element) {
      print(element);
    });
  });
}
