import 'dart:async';
import 'dart:convert';

import 'package:owlbot_dictionary/models/owlbot.dart';
import 'package:owlbot_dictionary/services/owlbot.dart';

class OwlbotManager {
  late StreamController<OwlbotResult> _streamController;
  late Stream<OwlbotResult> _stream;

  OwlbotManager() {
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  StreamController<OwlbotResult> get streamController => _streamController;
  Stream<OwlbotResult> get stream => _stream;

  void query(String keyword) async {
    if (keyword.isEmpty) {
      _streamController.sink.add(OwlbotResult(
          status: WordQueryStatus.error,
          errorMessage: '검색어를 입력하세요',
          definitions: []));
      return;
    }

    OwlbotResult queryResult =
        OwlbotResult(status: WordQueryStatus.inQuery, definitions: []);
    _streamController.sink.add(queryResult);

    String owlbotResponse = await OwlbotService.query(keyword);

    if (owlbotResponse.startsWith('[E]')) {
      queryResult.status = WordQueryStatus.error;
      queryResult.errorMessage = owlbotResponse;
      _streamController.sink.add(queryResult);
    } else {
      var jsonResults = json.decode(owlbotResponse);
      for (var jsonResult in jsonResults['definitions']) {
        WordDefinition definition = WordDefinition(
            word: keyword,
            type: jsonResult['type'] ?? '',
            definition: jsonResult['definition'] ?? '',
            imageUrl: jsonResult['image_url'] ?? '');
        queryResult.definitions.add(definition);
      }
      queryResult.status = WordQueryStatus.done;
      _streamController.sink.add(queryResult);
    }
  }
}
