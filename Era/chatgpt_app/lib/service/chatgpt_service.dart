import 'dart:async';

import 'package:chatgpt_app/model/chat_model.dart';
import 'package:dart_openai/openai.dart';

class ChatGptAnswer {
  final String content;
  final int totalTokens;

  ChatGptAnswer({required this.content, required  this.totalTokens});
}

class ChatGPTService {
  final _howLongRemember = 20;
  final String _apiKey = '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';
  final temperatures = [0.9, 0.6, 0.1]; // enum ChatTone {creativity, balance, exact}

  ChatGPTService() {
    OpenAI.apiKey = _apiKey;
  }

  Future<ChatGptAnswer> prompt(ChatModel chat, List<ChatModel> chats) async {

    List<OpenAIChatCompletionChoiceMessageModel> messages = [];

    for (final item in chats) {
      if (item.name == 'Shinny' && item.status == ChatStatus.complete) {
        messages.add(OpenAIChatCompletionChoiceMessageModel(role: "user", content: item.prompt));
        messages.add(OpenAIChatCompletionChoiceMessageModel(role: "assistant", content: item.text));
      }
    }
    
    // 마지막 _howLongRemember 개의 대화만 남긴다.
    messages = messages.sublist(messages.length >= _howLongRemember ? messages.length - _howLongRemember : 0, messages.length);

    // 첫번째 항목에는 ChatGPT의 역할 정보를 넣는다.
    messages.insert(0, OpenAIChatCompletionChoiceMessageModel(content: 'You are a helpful assistant.', role: "system"));

    // 마지막으로 사용자 질의어를 추가한다.
    messages.add(OpenAIChatCompletionChoiceMessageModel(role: "user", content: chat.prompt));

    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      temperature: temperatures[chat.tone.index],
      messages: messages,
    );

    print(chatCompletion);
    print(chatCompletion.usage.totalTokens);
    return ChatGptAnswer(content: chatCompletion.choices.last.message.content, totalTokens: chatCompletion.usage.totalTokens);
  }

  Future<ChatGptAnswer> answerRefresh(ChatModel chat, List<ChatModel> chats) async {
    return await prompt(chat, chats);
  }
}
