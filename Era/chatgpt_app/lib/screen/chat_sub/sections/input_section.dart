import 'package:chatgpt_app/model/chat_model.dart';
import 'package:chatgpt_app/providers/providers.dart';
import 'package:chatgpt_app/service/chatgpt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/send_button.dart';

class InputSection extends ConsumerStatefulWidget {
  const InputSection({Key? key}) : super(key: key);

  @override
  ConsumerState<InputSection> createState() => _ChatInputState();
}

class _ChatInputState extends ConsumerState<InputSection> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  final ChatGPTService chatGpt = ChatGPTService();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    Future.delayed(Duration.zero, () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatController = ref.read(chatProvider.notifier);

    ref.listen(selectedMenuProvider, (previous, next) {
      if (next == 5) _focusNode.requestFocus();
    });

    void addChat() {
      _focusNode.requestFocus();
      if (_textEditingController.text.isEmpty) return;

      final prompt = _textEditingController.text;
      _textEditingController.text = '';
      setState(() {});

      // 사용자 질의어 등록
      chatController.addChat(
        ChatModel(userSession: '김신한', name: 'Me', isMine: true, text: prompt, dateTime: DateTime.now()),
      );

      // 개인정보가 포함됐는지 확인
      RegExp pattern = RegExp(r'(^|[^\d])\d{6}-?\d{7}([^\d]|$)');
      if (pattern.hasMatch(prompt)) {
        chatController.addChat(
          ChatModel(
            userSession: '김신한',
            name: 'SYSTEM',
            isMine: false,
            text: '질의에 개인정보(주민번호)가 포함되어 있습니다.\nAI 챗봇 서비스 이용 유의사항을 재확인하시기 바랍니다.',
            dateTime: DateTime.now(),
            status: ChatStatus.warning,
          ),
        );
        return;
      }

      // Shinny 응답대기 등록
      final chat = ChatModel(
        userSession: '김신한',
        name: 'Shinny',
        isMine: false,
        text: '',
        prompt: prompt,
        dateTime: DateTime.now(),
        status: ChatStatus.waiting,
      );
      chatController.addChat(chat);

      // Shinny 답변 업데이트
      final chats = ref.read(chatProvider);
      chatGpt.prompt(chat, chats).then(
        (answer) {
          chat.text = answer.content.trim();
          chat.totalTokens = answer.totalTokens;
          chat.dateTime = DateTime.now();
          chat.status = ChatStatus.complete;
          chatController.updateChat(chat);
        },
      );
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        // color: Colors.yellow.shade100,
        border: Border(
          top: BorderSide(
            color: Color(0xFFDEE2E6),
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: Image.asset('assets/icons/chat-command.png', width: 20, height: 20),
            ),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 5,
                onSubmitted: (text) => addChat(),
                onChanged: (text) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 16),
                  border: InputBorder.none,
                  hintText: 'Shinny에게 무엇이든 물어보세요',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(bottom: 5),
              child: SendButton(
                onPressed: addChat,
                isActive: _textEditingController.text.isNotEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
