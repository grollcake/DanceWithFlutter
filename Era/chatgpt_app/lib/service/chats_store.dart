import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/chat_model.dart';

class ChatsStore {
  final db = FirebaseFirestore.instance;

  Future<String> add(ChatModel chat) async {
    return '';
    db.collection("chats").add(chat.toJson()).then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
      return doc.id;
    }).onError((error, stackTrace) {
      print('========= ERROR =============');
      print(error);
      print(stackTrace);
      return 'Something wrong!';
    });
    return 'Something wrong';
  }
}
