import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/inbox/models/message_model.dart';
import 'package:TikTok/features/inbox/repos/messages_repo.dart';
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
