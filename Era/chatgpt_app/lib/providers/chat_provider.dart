import 'package:chatgpt_app/model/chat_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider<ChatController, List<ChatModel>>((ref) => ChatController(chatList));