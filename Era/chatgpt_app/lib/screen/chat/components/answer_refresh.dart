import 'package:chatgpt_app/constants/styles.dart';
import 'package:chatgpt_app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../service/chatgpt_service.dart';

class AnswerRefresh extends ConsumerStatefulWidget {
  final ChatModel chat;
  final double size;

  AnswerRefresh({Key? key, required this.chat, required this.size}) : super(key: key);

  @override
  ConsumerState<AnswerRefresh> createState() => _AnswerRefreshState();
}

class _AnswerRefreshState extends ConsumerState<AnswerRefresh> {
  bool isExpanded = false;
  String selectedTone = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isExpanded) Column(
          children: [
            _buildOption(0),
            _buildOption(1),
            _buildOption(2),
          ],
        ),
        _buildRefreshButton(),
      ],
    );
  }

  Widget _buildRefreshButton() {
    return GestureDetector(
      onTap: (){
        setState(() {
          isExpanded = !isExpanded;
        });
      },

      child: Container(
        width: widget.size,
        height: widget.size,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.2),
        ),
        child: Center(
          child: Icon(
            isExpanded ? Icons.clear : Icons.refresh,
            color: Colors.grey,
            size: widget.size * .6,
          ),
        ),
      ),
    );
  }

  _buildOption(int choice) {
    final options = ['창작', '균형', '정확'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTone = options[choice];
          isExpanded = false;
        });
        _refresh();
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Chip(label: Text(options[choice]), backgroundColor: toneColors[choice].withOpacity(.5)),
      ),
    );
  }

  void _refresh() {
    final chat = widget.chat;

    if (selectedTone == '창작') {
      chat.tone = ChatTone.creativity;
    } else if (selectedTone == '균형') {
      chat.tone = ChatTone.balance;
    } else if (selectedTone == '정확') {
      chat.tone = ChatTone.exact;
    }
    chat.status = ChatStatus.waiting;

    final chatController = ref.read(chatProvider.notifier);
    chatController.updateChat(chat);

    // Shinny 재답변
    final chats = ref.read(chatProvider);
    final ChatGPTService chatGpt = ChatGPTService();
    chatGpt.answerRefresh(widget.chat, chats).then(
          (answer) {
        widget.chat.text = answer.content.trim();
        widget.chat.totalTokens = answer.totalTokens;
        widget.chat.dateTime = DateTime.now();
        widget.chat.status = ChatStatus.complete;
        chatController.updateChat(widget.chat);
      },
    );
  }
}
