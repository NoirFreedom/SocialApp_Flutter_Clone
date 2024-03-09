import 'package:TikTok/features/inbox/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//! chatroom id를 인자로 받아야 함 (Firebase Firestore에 저장할 때 chatroom id를 받아야 함)
  Future<void> sendMessage(MessageModel message, String chatRoomId) async {
    await _db
        .collection("chat_rooms")
        .doc("Fcinkw8THtQAQQrSnsaV")
        .collection("texts")
        .add(
          message.toJson(),
        );
  }
}

final messagesRepo = Provider((ref) => MessagesRepository());
