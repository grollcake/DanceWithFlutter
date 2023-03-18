import 'package:chatgpt_app/model/chat_model.dart';
import 'package:chatgpt_app/model/test_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/chat_controller.dart';

///////////////////////////////////////////////////////////////////////////
final costViewProvider = StateProvider((ref) => false);
final costTotalProvider = StateProvider((ref) => 0.0);

///////////////////////////////////////////////////////////////////////////
final isReAnswerOpenedProvider = StateProvider<bool>((ref) => false);

///////////////////////////////////////////////////////////////////////////
final chatProvider = StateNotifierProvider<ChatController, List<ChatModel>>((ref) => ChatController(ref, preloadChats));

///////////////////////////////////////////////////////////////////////////
enum DeviceType {mobile, tablet, desktop, tiny}
DeviceType deviceType = DeviceType.mobile;