import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchCountryList {
  static String _url =
      'https://gist.githubusercontent.com/keeguon/2310008/raw/bdc2ce1c1e3f28f9cab5b4393c7549f38361be4e/countries.json';

  Future<List<String>> getCountryList() async {
    List<String> allCountries = [];
    http.Response response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      Map<String, dynamic> countries = json.decode(_normalization(response.body));
      for (var element in countries['countries']) {
        allCountries.add(element['name']);
      }
    }
    return allCountries;
  }

  String _normalization(String malformed) {
    String welformed = '{"countries": ' + malformed + '}';
    welformed = welformed.replaceAll('\'', '"');
    welformed = welformed.replaceAll('name:', '"name":');
    welformed = welformed.replaceAll('code:', '"code":');
    return welformed;
  }
}

main() async {
  print(await FetchCountryList().getCountryList());
}
