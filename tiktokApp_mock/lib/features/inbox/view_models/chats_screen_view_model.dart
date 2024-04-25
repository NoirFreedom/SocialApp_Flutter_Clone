import 'dart:async';

import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenViewModel extends AsyncNotifier<String> {
  Future<String> getOtherName(String currentUid) async {
    //! 상태방 유저이름을 가져오기 위한 코드
    final result = await ref.read(chatRoomsRepo).getUsersInfo();
    final otherName = result.docs
        .map((doc) => doc.data())
        .where((element) => element["uid"] != currentUid)
        .first["name"];
    print('Other Name: $otherName');
    return otherName;
  }

  @override
  FutureOr<String> build() async {
    return "";
  }
}

final chatScreenProvider = AsyncNotifierProvider<ChatScreenViewModel, String>(
    () => ChatScreenViewModel());
