import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 채팅방을 생성하는 코드
  Future<void> createChatroom(
      String uid, String friendUid, String chatRoomId) async {
    print("chatRoomId on chatRoomsRepository: $chatRoomId");
    DocumentReference chatRoomRef =
        _db.collection("chat_rooms").doc(chatRoomId);

    final chatRoomSnapshot = await chatRoomRef.get();
    if (!chatRoomSnapshot.exists) {
      await chatRoomRef.set({
        "participants": [uid, friendUid],
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
      // 'texts' 서브 컬렉션 생성 및 초기화
      CollectionReference textsRef = chatRoomRef.collection("texts");
      await textsRef.add({
        "chatRoomId": chatRoomId,
        "text": "Chat room created",
        "userId": uid,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  // '+' 버튼을 눌렀을 때 친구 목록을 불러오는 코드
  Future<QuerySnapshot<Map<String, dynamic>>> participantsInfo() async {
    final query = _db.collection("users");
    return query.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getParticipantUid(
      String chatroomId) async {
    final chatRoomRef = _db.collection("chat_rooms").doc(chatroomId);
    return chatRoomRef.get();
  }

  Future<void> deleteChatroom(String chatroomId) async {}
}

final chatRoomsRepoProvider = Provider((ref) => ChatRoomsRepository());
