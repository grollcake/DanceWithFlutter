import 'package:chatgpt_app/model/chat_model.dart';
import 'package:chatgpt_app/model/test_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final costViewProvider = StateProvider((ref) => false);
final costTotalProvider = StateProvider((ref) => 0.0);

final chatProvider = StateNotifierProvider<ChatController, List<ChatModel>>((ref) => ChatController(ref, preloadChats));


class ChatController extends StateNotifier<List<ChatModel>> {
  final Ref ref;
  ChatController(this.ref, [List<ChatModel>? chats]) : super(chats ?? []);

  void addChat(ChatModel chat) {
    final List<ChatModel> newChatList = [...state, chat];

    for (int i = 0; i < newChatList.length; i++) {
      if (i == newChatList.length - 1 &&
          newChatList[i].name == 'Shinny' &&
          newChatList[i].status == ChatStatus.complete) {
        newChatList[i].isLastAnswer = true;
      } else {
        newChatList[i].isLastAnswer = false;
      }
    }

    if (chat.name == 'Shinny' && chat.status == ChatStatus.complete) {
      _updateTotalCost(chat.totalTokens);
    }

    state = newChatList;
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

    for (int i = 0; i < newChatList.length; i++) {
      if (i == newChatList.length - 1 &&
          newChatList[i].name == 'Shinny' &&
          newChatList[i].status == ChatStatus.complete) {
        newChatList[i].isLastAnswer = true;
      } else {
        newChatList[i].isLastAnswer = false;
      }
    }

    if (chat.name == 'Shinny' && chat.status == ChatStatus.complete) {
      _updateTotalCost(chat.totalTokens);
    }

    state = newChatList;
  }

  void _updateTotalCost(int tokens) {
    ref.read(costTotalProvider.notifier).state = ref.read(costTotalProvider.notifier).state + 0.002 * tokens / 1000;
  }
}
