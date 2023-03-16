import 'dart:async';

import 'package:dart_openai/openai.dart';

class ChatGPTService {
  final String _apiKey = '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';

  ChatGPTService() {
    OpenAI.apiKey = _apiKey;
  }

  Future<String> prompt(String prompt) async {
    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(content: prompt, role: "user"),
      ],
    );

    print(chatCompletion.choices.length);
    return chatCompletion.choices.last.message.content;
  }
}

void main() async {
  final ChatGPTService chatGpt = ChatGPTService();
  print(await chatGpt.prompt('안녕 넌 누구니?'));
  print(await chatGpt.prompt('반가워, 난 홍길동이야'));
  print(await chatGpt.prompt('내 이름이 뭐야?'));
  print(await chatGpt.prompt('flutter가 뭐야?'));
}

// void main() async {
//   OpenAI.apiKey = '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';
//   Stream<OpenAIStreamChatCompletionModel> chatStream = OpenAI.instance.chat.createStream(
//     model: "gpt-3.5-turbo",
//     messages: [
//       OpenAIChatCompletionChoiceMessageModel(
//         content: "what is flutter?",
//         role: "user",
//       )
//     ],
//   );
//
//   chatStream.listen((chatStreamEvent) {
//     print(chatStreamEvent); // ...
//   });
// }
