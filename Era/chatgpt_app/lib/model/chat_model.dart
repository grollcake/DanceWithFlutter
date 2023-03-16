import 'package:chatgpt_app/service/chats_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ChatController extends StateNotifier<List<ChatModel>> {
  ChatController([List<ChatModel>? chats]) : super(chats ?? []);

  void addChat(ChatModel chat) {
    state = [...state, chat];
    // ChatsStore().add(chat);
  }

  void updateChat(ChatModel chat) {
    final List<ChatModel> newChatList = [];

    for (final preChat in state) {
      if (preChat.ulid == chat.ulid) {
        newChatList.add(chat);
      } else {
        newChatList.add(preChat);
      }
    }

    state = newChatList;
  }
}

final List<ChatModel> chatList = [
  ChatModel(
      userSession: '김신한', name: 'Me', isMine: true, text: '안녕, 넌 누구니?', dateTime: DateTime(2023, 3, 14, 19, 15, 42)),
  ChatModel(
      userSession: '김신한',
      name: 'Shinny',
      isMine: false,
      text: '안녕하세요! 저는 OpenAI에서 개발된 대화형 인공지능 모델인 ChatGPT입니다. 무엇을 도와드릴까요?',
      dateTime: DateTime(2023, 3, 14, 19, 15, 44)),
  ChatModel(
      userSession: '김신한',
      name: 'Me',
      isMine: true,
      text: '넌 어떤 것들을 할 수 있니?',
      dateTime: DateTime(2023, 3, 15, 9, 22, 30)),
  ChatModel(
      userSession: '김신한',
      name: 'Shinny',
      isMine: false,
      text: '''저는 다음과 같은 것들을 할 수 있습니다:
자연어 이해(Natural Language Understanding)
자연어 생성(Natural Language Generation)
질문 답변(Question Answering)
대화(Dialogue)
이미지 및 텍스트 분류(Image and Text Classification)
생성 모델(Generative Model)
추천 시스템(Recommendation System)
감정 분석(Sentiment Analysis)
기계 번역(Machine Translation)
음성 인식(Speech Recognition)''',
      dateTime: DateTime(2023, 3, 15, 9, 22, 33)),
];
