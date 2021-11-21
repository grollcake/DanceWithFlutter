import 'package:http/http.dart' as http;

class SearchService {
  static const _url = 'https://owlbot.info/api/v4/dictionary/';
  static const _token = '20494ad45f0f9c416abe2576c9793657e0ab1d6c';

  static Future<String> search(String word) async {
    Uri searchUrl = Uri.parse(_url + word);
    Map<String, String> header = {'Authorization': 'Token $_token'};
    http.Response response = await http.get(searchUrl, headers: header);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Something wrong: ${response.statusCode}';
    }
  }
}

main() async => print(await SearchService.search('book'));
