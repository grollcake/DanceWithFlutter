import 'package:chatgpt_app/model/chat_model.dart';
import 'package:chatgpt_app/model/test_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider<ChatController, List<ChatModel>>((ref) => ChatController(preloadChats));

class ChatController extends StateNotifier<List<ChatModel>> {
  ChatController([List<ChatModel>? chats]) : super(chats ?? []);

  void addChat(ChatModel chat) {
    state = [...state, chat];
    // ChatsStore().add(chat);
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

    state = newChatList;
  }
}
