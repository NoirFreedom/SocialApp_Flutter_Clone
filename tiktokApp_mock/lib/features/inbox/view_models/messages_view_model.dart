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

//! chatroom id를 인자로 받아야 함
  Future<void> sendMessage(String text, String chatRoomId) async {
    final user = ref.read(authRepo).user;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final message = MessageModel(
          text: text,
          userId: user!.uid,
          chatRoomId: "Fcinkw8THtQAQQrSnsaV",
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        _messagesRepository.sendMessage(message, "Fcinkw8THtQAQQrSnsaV");
      },
    );
  }
}

final messagesProvider =
    AsyncNotifierProvider.family<MessagesViewModel, void, String>(
  () => MessagesViewModel(),
);

//! chat_rooms의 id가 들어가도록 수정해야 함
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc("Fcinkw8THtQAQQrSnsaV")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => MessageModel.fromJson(doc.data())).toList());
});
