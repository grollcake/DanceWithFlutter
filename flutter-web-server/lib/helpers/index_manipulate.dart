import 'dart:io';

Future<String> extractProjectName(String indexPath) async {
  var contents = await new File(indexPath).readAsString();

  RegExp regex = RegExp(r'<title>(.+?)</title>', caseSensitive: false, dotAll: false);
  var titleMatch = regex.firstMatch(contents);
  if (titleMatch != null) {
    return titleMatch.group(1).toString();
  } else {
    return '';
  }
}

Future<bool> changeBaseHref(String indexPath, String baseHref) async {
  // index.html에 들어갈 base href에는 앞뒤로 패스구분자를 붙여야한다.
  // project1 => /project1/
  String href = baseHref.startsWith('/') ? baseHref : '/' + baseHref;
  href = baseHref.endsWith('/') ? href : href + '/';

  // index.html 파일을 읽어들인다.
  var contents = await new File(indexPath).readAsString();

  // baseHref를 찾아서 변경해야될지 여부를 판단한다.
  RegExp regex = RegExp(r'<base href="(.+?)">', caseSensitive: false, dotAll: false);
  var hrefMatch = regex.firstMatch(contents);
  String currentHref = hrefMatch?.group(1).toString() ?? '';

  if (currentHref == href) {
    return true;
  } else {
    print('Changing $currentHref to $href');
    String newContents = contents.replaceFirst(hrefMatch.group(0).toString(), '<base href="$href">');
    await new File(indexPath).writeAsString(newContents);
    return true;
  }
}

void main() => changeBaseHref(
    'D:\\flutter-dev\\DanceWithFlutter\\Era\\_1104_alert_dialog\\build\\web\\index.html', '_1104_alert_dialog');
