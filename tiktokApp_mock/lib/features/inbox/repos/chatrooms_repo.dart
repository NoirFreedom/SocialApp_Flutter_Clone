import 'package:TikTok/features/inbox/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createChatroomId(String uid, String friendUid) {
    List<String> uids = [uid, friendUid];
    uids.sort();
    return "${uids[0]}_${uids[1]}";
  }

//! chatroom id를 인자로 받아야 함 (Firebase Firestore에 저장할 때 chatroom id를 받아야 함)
  Future<void> createChatroom(String uid, String friendUid) async {
    String chatRoomId = createChatroomId(uid, friendUid);
    DocumentReference chatRoomRef =
        _db.collection("chat_rooms").doc(chatRoomId);

    final chatRoomSnapshot = await chatRoomRef.get();
    if (!chatRoomSnapshot.exists) {
      await chatRoomRef.set({
        "participants": [uid, friendUid],
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  Future<List<Map<String, dynamic>>> loadFriends() async {
    final users = await _db.collection("users").get();
    return users.docs.map((doc) => doc.data()).toList();
  }

  Future<void> loadChatroom(String chatroomId) async {}

  Future<void> deleteChatroom(String chatroomId) async {}
}

final chatRoomsRepo = Provider((ref) => ChatRoomsRepository());
