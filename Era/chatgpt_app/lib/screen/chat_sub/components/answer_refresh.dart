import 'package:chatgpt_app/constants/styles.dart';
import 'package:chatgpt_app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../service/chatgpt_service.dart';

class AnswerRefresh extends ConsumerWidget {
  final ChatModel chat;
  final double size;

  AnswerRefresh({super.key, required this.chat, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReAnswerOpened = ref.watch(isReAnswerOpenedProvider);

    return Column(
      children: [
        if (isReAnswerOpened) Column(
          children: [
            _buildToneButton(0, ref),
            _buildToneButton(1, ref),
            _buildToneButton(2, ref),
          ],
        ),
        _buildOpenCloseButton(ref),
      ],
    );
  }

  Widget _buildOpenCloseButton(WidgetRef ref) {
    final isReAnswerOpened = ref.watch(isReAnswerOpenedProvider);
    return GestureDetector(
      onTap: (){
        ref.read(isReAnswerOpenedProvider.notifier).state = !ref.read(isReAnswerOpenedProvider);
      },

      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.2),
        ),
        child: Center(
          child: Icon(
            isReAnswerOpened ? Icons.clear : Icons.refresh,
            color: Colors.grey,
            size: size * .6,
          ),
        ),
      ),
    );
  }

  _buildToneButton(int choice, WidgetRef ref) {
    final options = ['창작', '균형', '정확'];

    return GestureDetector(
      onTap: () {
          chat.tone = ChatTone.values[choice];
          ref.read(isReAnswerOpenedProvider.notifier).state =  false;
        _requestReAnswer(ref);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Chip(label: Text(options[choice]), backgroundColor: toneColors[choice].withOpacity(.5)),
      ),
    );
  }

  void _requestReAnswer(WidgetRef ref) {

    chat.status = ChatStatus.waiting;

    final chatController = ref.read(chatProvider.notifier);
    chatController.updateChat(chat);

    // Shinny 재답변
    final chats = ref.read(chatProvider);
    final ChatGPTService chatGpt = ChatGPTService();
    chatGpt.answerRefresh(chat, chats).then(
          (answer) {
        chat.text = answer.content.trim();
        chat.totalTokens = answer.totalTokens;
        chat.dateTime = DateTime.now();
        chat.status = ChatStatus.complete;
        chatController.updateChat(chat);
      },
    );
  }
}
