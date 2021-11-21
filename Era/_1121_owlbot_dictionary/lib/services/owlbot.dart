import 'dart:convert';

import 'package:http/http.dart' as http;

class OwlbotService {
  static const String _url = 'https://owlbot.info/api/v4/dictionary/';
  static const String _token = '20494ad45f0f9c416abe2576c9793657e0ab1d6c';

  static Future<String> query(String keyword) async {
    String result = '';

    Uri queryUrl = Uri.parse(_url + keyword);
    Map<String, String> header = {'Authorization': 'Token $_token'};

    http.Response response = await http.get(queryUrl, headers: header);

    if (response.statusCode != 200) {
      result = '[E] ${response.statusCode}';
      if (response.body.isNotEmpty) {
        var errorData = json.decode(response.body);
        var firstError = errorData is List ? errorData[0] : errorData;
        for (String element in ['detail', 'message']) {
          if (firstError.containsKey(element)) {
            result += ' ${firstError[element]}';
          }
        }
      }
    } else {
      result = response.body;
    }

    return result;
  }
}

void main() async {
  print(await OwlbotService.query('dog'));
}
