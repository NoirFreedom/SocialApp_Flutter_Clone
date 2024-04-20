import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createChatroomId(String uid, String friendUid) {
    List<String> uids = [uid, friendUid];
    uids.sort();
    return "${uids[0]}_${uids[1]}";
  }

  // 채팅방을 생성하는 코드
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

  // '+' 버튼을 눌렀을 때 친구 목록을 불러오는 코드
  Future<List<Map<String, dynamic>>> getUsersInfo() async {
    final users = await _db.collection("users").get();
    return users.docs.map((doc) => doc.data()).toList();
  }

  Future<void> loadChatroom(String chatroomId) async {}

  Future<void> deleteChatroom(String chatroomId) async {}
}

final chatRoomsProvider = Provider((ref) => ChatRoomsRepository());
