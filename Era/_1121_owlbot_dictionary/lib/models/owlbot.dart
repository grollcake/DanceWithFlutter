class WordDefinition {
  final String type;
  final String definition;
  final String? imageUrl;
  final String word;

  WordDefinition(
      {required this.type,
      required this.definition,
      this.imageUrl,
      required this.word});
}

enum WordQueryStatus { inQuery, done, error }

class OwlbotResult {
  List<WordDefinition> definitions;
  WordQueryStatus status;
  String? errorMessage;

  OwlbotResult(
      {required this.status, required this.definitions, this.errorMessage});
}
