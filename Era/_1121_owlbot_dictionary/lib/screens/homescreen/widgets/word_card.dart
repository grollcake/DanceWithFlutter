import 'package:flutter/material.dart';
import 'package:owlbot_dictionary/models/owlbot.dart';

class WordCard extends StatelessWidget {
  const WordCard({Key? key, required this.definition}) : super(key: key);

  final WordDefinition definition;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      trailing: definition.imageUrl?.isNotEmpty ?? false ? Image.network(definition.imageUrl!) : null,
      title: Text(definition.type),
      subtitle: Text(
        definition.definition,
      ),
    );
  }
}
