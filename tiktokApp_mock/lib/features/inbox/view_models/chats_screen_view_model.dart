import 'dart:async';
import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenViewModel extends AsyncNotifier<String> {
  Future<Map<String, dynamic>?> getOtherInfo(String targetUid) async {
    final result = await ref.read(chatRoomsRepoProvider).participantsInfo();
    try {
      final Map<String, dynamic> userInfo = result.docs
          .map((doc) => doc.data())
          .firstWhere((element) => element["uid"] == targetUid);
      return userInfo;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getChatroomInfo(String uid) async {
    final result = await ref.read(chatRoomsRepoProvider).participantsInfo();
    try {
      final Map<String, dynamic> userInfo = result.docs
          .map((doc) => doc.data())
          .firstWhere((element) => element["uid"] == uid);
      return userInfo;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureOr<String> build() async {
    return "";
  }
}

final chatScreenProvider = AsyncNotifierProvider<ChatScreenViewModel, String>(
    () => ChatScreenViewModel());
