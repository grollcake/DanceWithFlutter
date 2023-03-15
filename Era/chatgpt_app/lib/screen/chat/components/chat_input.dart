import 'package:chatgpt_app/model/chat_data.dart';
import 'package:chatgpt_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'send_button.dart';

class ChatInput extends ConsumerStatefulWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends ConsumerState<ChatInput> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.read(chatProvider.notifier);

    void _addChat() {
      chats.addChat(ChatModel(name: 'Me', isMine: true, text: _textEditingController.text , dateTime: DateTime.now()));
      _textEditingController.text = '';
      setState(() {
      });
    }

    return Container(
      height: 40,
      width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: Image.asset('assets/icons/chat-command.png', width: 20, height: 20),
            ),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                onSubmitted: (text) {
                  _addChat();
                },
                onChanged: (text) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(bottom: 3),
                  border: InputBorder.none,
                  hintText: 'Shinny에게 무엇이든 물어보세요',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ),
            SendButton(
              onPressed: _addChat,
              isActive: _textEditingController.text.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
