import 'dart:async';

import 'package:chatgpt_app/model/chat_data.dart';
import 'package:chatgpt_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatBody extends ConsumerStatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends ConsumerState<ChatBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    print('chat_body disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final chats = ref.watch(chatProvider);

    ref.listen(chatProvider, (previous, next) {
      if (previous!.length < next.length) {
        print('New item added');
        Timer(Duration(milliseconds: 100), () {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        });
      }
    });

    return Container(
      padding: EdgeInsets.all(16),
      // color: Color(0xFFDBE4FB),
      child: ListView.builder(
          controller: _scrollController,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];

            Widget timeString = _buildTimeString(chat);
            Widget chatBubble = _buildChatBubble(chat);

            // My chat
            if (chat.isMine) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(flex: 1),
                    timeString,
                    SizedBox(width: 16),
                    Expanded(flex: 7, child: chatBubble),
                  ],
                ),
              );
            }

            // Shinny's Chat
            else {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/shinny.png'),
                      backgroundColor: Colors.transparent,
                      radius: 16,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.name,
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 9,
                                child: chatBubble,
                              ),
                              SizedBox(width: 16),
                              timeString,
                              Spacer(flex: 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget _buildTimeString(ChatModel chat) {
    // print(chat.dateTime);
    final hourFormat = NumberFormat('00');
    final minuteFormat = NumberFormat('00');
    final secondFormat = NumberFormat('00');

    String amPm = chat.dateTime.hour < 12 ? '오전' : '오후';
    int hour = chat.dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour;

    String formattedHour = hourFormat.format(hour);
    String formattedMinute = minuteFormat.format(chat.dateTime.minute);
    String formattedSecond = secondFormat.format(chat.dateTime.second);

    final timeString = '$amPm $formattedHour:$formattedMinute';
    return Text(
      timeString,
      style: TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  Widget _buildChatBubble(ChatModel chat) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: chat.isMine ? Color(0xFFDBE4FB) : Color(0xFFF4F6F8),
      ),
      child: Text(
        chat.text,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
