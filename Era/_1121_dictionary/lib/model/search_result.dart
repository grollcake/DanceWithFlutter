enum SearchStatus { inSearching, done, error }

class Definition {
  final String type;
  final String definition;
  final String example;
  final String imageUrl;

  Definition({required this.type, required this.definition, required this.example, required this.imageUrl});

  Definition.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        definition = json['definition'],
        example = json['example'] ?? '',
        imageUrl = json['image_url'] ?? '';
}

class SearchResult {
  SearchStatus status;
  String errorMessage;
  List<Definition>? definitions;

  SearchResult({required this.status, this.errorMessage = '', this.definitions});
}
