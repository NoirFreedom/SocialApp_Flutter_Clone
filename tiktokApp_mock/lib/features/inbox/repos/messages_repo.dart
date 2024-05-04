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
}

final messagesRepo = Provider((ref) => MessagesRepository());
