import 'package:ulid/ulid.dart';

enum ChatStatus { waiting, complete, warning }

class ChatModel {
  final String ulid;
  final String userSession;
  final String name;
  final bool isMine;
  String text;
  DateTime dateTime;
  ChatStatus status;

  ChatModel({
    required this.userSession,
    required this.name,
    required this.isMine,
    required this.text,
    required this.dateTime,
    this.status = ChatStatus.complete,
  }) : ulid = Ulid().toString();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "userSession": userSession,
      "name": name,
      "isMine": isMine,
      "text": text,
      "dateTime": dateTime.toIso8601String(),
    };
  }
}



