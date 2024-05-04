import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/inbox/models/message_model.dart';
import 'package:TikTok/features/inbox/repos/messages_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessagesRepository _messagesRepository;

  @override
  FutureOr<void> build(String args) {
    _messagesRepository = ref.read(messagesRepo);
  }

  Future<void> sendMessage(String text, String chatRoomId) async {
    final user = ref.read(authRepo).user;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final message = MessageModel(
          text: text,
          userId: user!.uid,
          chatRoomId: chatRoomId,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        _messagesRepository.sendMessage(message, chatRoomId);
      },
    );
  }
}

final messagesProvider =
    AsyncNotifierProvider.family<MessagesViewModel, void, String>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider.autoDispose
    .family<List<MessageModel>, String>((ref, chatroomId) {
  // autoDispose를 사용하여 채팅방을 나갔을 때 데이터를 삭제하도록 함
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc(chatroomId)
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => MessageModel.fromJson(doc.data())).toList());
});
