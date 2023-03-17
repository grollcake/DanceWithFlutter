import 'package:ulid/ulid.dart';

enum ChatStatus { waiting, complete, warning }
enum ChatTone {creativity, balance, exact}

class ChatModel {
  final String ulid;
  final String userSession;
  final String name;
  final bool isMine;
  String text;
  String prompt;
  DateTime dateTime;
  ChatStatus status;
  bool isLastAnswer;
  ChatTone tone;
  int totalTokens;

  ChatModel({
    required this.userSession,
    required this.name,
    required this.isMine,
    required this.text,
    this.prompt = '',
    required this.dateTime,
    this.status = ChatStatus.complete,
    this.isLastAnswer = false,
    this.tone = ChatTone.balance,
    this.totalTokens = 0,
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



