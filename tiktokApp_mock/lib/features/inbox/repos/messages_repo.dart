import 'package:TikTok/features/inbox/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message, String chatRoomId) async {
    print("chatRoomId on messages_repo: $chatRoomId");
    await _db.collection("chat_rooms").doc(chatRoomId).collection("texts").add(
          message.toJson(),
        );
  }

  // 메세지 삭제 기능
  Future<void> deleteMessage(int createdAt, String chatRoomId) async {
    QuerySnapshot querySnapshot = await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("texts")
        .where("createdAt", isEqualTo: createdAt)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.delete();
    }
  }
}

final messagesRepo = Provider((ref) => MessagesRepository());
