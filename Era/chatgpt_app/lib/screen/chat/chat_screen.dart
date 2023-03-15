import 'package:flutter/material.dart';

import 'components/chat_body.dart';
import 'components/chat_header.dart';
import 'components/chat_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatHeader(),
        Expanded(
          child: ChatBody(),
        ),
        ChatInput(),
      ],
    );
  }
}
