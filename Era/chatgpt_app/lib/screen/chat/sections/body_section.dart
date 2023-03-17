import 'dart:async';
import 'dart:ui';

import 'package:chatgpt_app/constants/styles.dart';
import 'package:chatgpt_app/model/chat_model.dart';
import 'package:chatgpt_app/providers/providers.dart';
import 'package:chatgpt_app/screen/chat/components/answer_refresh.dart';
import 'package:chatgpt_app/screen/chat/components/tone_indicator.dart';
import 'package:chatgpt_app/screen/chat/components/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../components/common_functions.dart';

class ChatBody extends ConsumerStatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends ConsumerState<ChatBody> {
  late ScrollController _scrollController;
  bool _showWarning = true;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatProvider);

    ref.listen(chatProvider, (previous, next) {
      Timer(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      });
    });

    ref.listen(isReAnswerOpenedProvider, (previous, next) {
      print('ReAnswer button Open/Close event detected: $next');
      Timer(Duration(milliseconds: 100), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
    });

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(16),
            child: LayoutBuilder(builder: (context, constraints) {
              final double edgeMargin = constraints.maxWidth * .10;

              return ListView.builder(
                  controller: _scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];

                    if (chat.status == ChatStatus.warning) {
                      return _buildWarning(chat);
                    }
                    // My chat
                    else if (chat.isMine) {
                      return _buildMyChat(chat, edgeMargin);
                    }
                    // Shinny's Chat
                    else {
                      return _buildShinnyChat(chat, edgeMargin);
                    }
                  });
            }),
          ),
        ),
        if (_showWarning)
          Positioned(
            child: _buildAlertLayer(),
          ),
      ],
    );
  }

  Widget _buildAlertLayer() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.pink.withOpacity(.1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/warning.png'),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Shinny는 OpenAI의 ChatGPT를 기반으로 합니다. 질문에 고객정보 등 민감내용이 포함되지 않도록 유의하세요. 사고에 대비하여 모든 대화는 기록됩니다.',
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showWarning = false;
                    });
                  },
                  child: Icon(Icons.clear_sharp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShinnyChat(ChatModel chat, double edgeMargin) {
    final isCostView = ref.watch(costViewProvider);

    Widget timeString = _buildTimeString(chat);
    Widget chatBubble = _buildChatBubble(chat);
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(child: chatBubble),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (chat.isLastAnswer) AnswerRefresh(chat: chat, size: 24),
                          timeString,
                        ],
                      ),
                    ],
                  ),
                ),
                if (isCostView && chat.totalTokens > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Row(
                      children: [
                        Text(
                          buildCostString(chat.totalTokens),
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: edgeMargin),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatModel chat) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 700
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: chat.isMine ? Color(0xFFDBE4FB) : Color(0xFFF4F6F8),
        ),
        child: Stack(
          children: [
            chat.status == ChatStatus.complete
                ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                      chat.text,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                )
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: 60,
                      height: 40,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballBeat,
                        colors: toneColors,
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
            if (chat.name == 'Shinny' && chat.status == ChatStatus.complete)
              Positioned(
                right: 5,
                bottom: 5,
                child: ToneIndicator(tone: chat.tone),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyChat(ChatModel chat, double edgeMargin) {
    Widget timeString = _buildTimeString(chat);
    Widget chatBubble = _buildChatBubble(chat);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: edgeMargin),
          timeString,
          SizedBox(width: 8),
          Flexible(child: chatBubble),
        ],
      ),
    );
  }

  Widget _buildTimeString(ChatModel chat) {
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

  Widget _buildWarning(ChatModel chat) {
    return Center(
      child: WarningMessage(message: chat.text),
    );
  }
}
