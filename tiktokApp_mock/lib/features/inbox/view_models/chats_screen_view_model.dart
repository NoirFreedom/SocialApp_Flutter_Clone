import 'dart:async';

import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenViewModel extends AsyncNotifier<String> {
  Future<Map<String, dynamic>?> getOtherInfo(String currentUid) async {
    final result = await ref.read(chatRoomsRepo).getUsersInfo();
    final Map<String, dynamic> otherInfo = result.docs
        .map((doc) => doc.data())
        .firstWhere((element) => element["uid"] != currentUid);
    return otherInfo;
  }

  @override
  FutureOr<String> build() async {
    return "";
  }
}

final chatScreenProvider = AsyncNotifierProvider<ChatScreenViewModel, String>(
    () => ChatScreenViewModel());
