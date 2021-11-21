import 'dart:async';
import 'dart:convert';

import 'package:dictionary/model/search_result.dart';
import 'package:dictionary/services/search_service.dart';

class DictionaryManager {
  late StreamController<SearchResult> _streamController;
  late Stream<SearchResult> _stream;

  DictionaryManager() {
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  StreamController get streamController => _streamController;
  Stream get stream => _stream;

  void _streamAdd(SearchResult result) => _streamController.sink.add(result);

  void search(String word) async {
    // 검색어를 입력하지 않았다면 오류를 리턴한다.
    if (word.trim().isEmpty) {
      _streamAdd(SearchResult(status: SearchStatus.error, errorMessage: '먼저 검색어를 입력하세요'));
      return;
    }

    // 화면에 검색 중이라는 상태를 표현하기 위해 stream으로 상태를 내보낸다.
    _streamAdd(SearchResult(status: SearchStatus.inSearching));

    // 인터넷 사전서비스에서 검색한다.
    String result = await SearchService.search(word);

    // json 형식이면 정상적인 결과가 들어온 것이다. 여러개의 정의가 배열로 되어 있기 때문에 하나씩 객체로 변환하여 stream에 넣는다.
    if (result.startsWith('{')) {
      SearchResult searchResult = SearchResult(status: SearchStatus.done, definitions: []);
      var jsonResult = json.decode(result);
      for (var jsonDefinition in jsonResult['definitions']) {
        searchResult.definitions!.add(Definition.fromJson(jsonDefinition));
        _streamAdd(searchResult);
      }
    } else {
      _streamAdd(SearchResult(status: SearchStatus.error, errorMessage: result));
    }
  }
}
