import 'dart:convert';

import 'package:http/http.dart' as http;

const String _apiUrl = 'https://owlbot.info/api/v4/dictionary/';
const String _apiToken = '20494ad45f0f9c416abe2576c9793657e0ab1d6c';

Future<String> owlBot(String word) async {
  // Query example
  // curl --header "Authorization: Token 20494ad45f0f9c416abe2576c9793657e0ab1d6c" https://owlbot.info/api/v4/dictionary/owl -s | json_pp
  // {
  //   "definitions" : [
  //    {
  //      "definition" : "a nocturnal bird of prey with large eyes, a facial disc, a hooked beak, and typically a loud hooting call.",
  //      "emoji" : "ð",
  //      "example" : "I love reaching out into that absolute silence, when you can hear the owl or the wind.",
  //      "image_url" : "https://media.owlbot.info/dictionary/images/hhhhhhhhhhhhhhhhhhhu.jpg.400x400_q85_box-15,0,209,194_crop_detail.jpg",
  //      "type" : "noun"
  //    }
  //  ],
  // "pronunciation" : "oul",
  // "word" : "owl"
  // }
  String reqUrl = _apiUrl + word;

  print('Searching for $word from $reqUrl');

  http.Response response = await http.get(Uri.parse(reqUrl), headers: {'Authorization': 'Token $_apiToken'});

  print(response.statusCode);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return '[E] abnormal return code: ${response.statusCode}';
  }
}

main() async {
  String result = await owlBot('dog');
  print(json.decode(result));

}