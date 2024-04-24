import 'dart:async';

import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenViewModel
    extends AsyncNotifier<QuerySnapshot<Map<String, dynamic>>> {
  Future<QuerySnapshot<Map<String, dynamic>>> getOtherName(
      String userId) async {
    final result = await ref.read(chatRoomsProvider).getUsersInfo();
    //! 상태방 유저이름을 가져오기 위한 코드
  }

  @override
  FutureOr<String> build() {}
}

final chatScreenProvider = AsyncNotifierProvider<ChatScreenViewModel, String>(
    () => ChatScreenViewModel());
