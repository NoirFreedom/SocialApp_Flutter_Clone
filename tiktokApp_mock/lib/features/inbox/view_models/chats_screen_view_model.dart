import 'dart:async';

import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenViewModel extends AsyncNotifier<String> {
  //! 상대방의 정보를 불러와 view에서 사용 가능하도록 수정할 것
  Future<String> getOtherInfo(String currentUid) async {
    final result = await ref.read(chatRoomsRepo).getUsersInfo();
    print("Test: $result");
    final otherInfo = result.docs
        .map((doc) => doc.data())
        .where((element) => element["uid"] != currentUid)
        .first["name"];
    return otherInfo;
  }

  @override
  FutureOr<String> build() async {
    return "";
  }
}

final chatScreenProvider = AsyncNotifierProvider<ChatScreenViewModel, String>(
    () => ChatScreenViewModel());
