import 'dart:async';
import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUsersViewModel extends AsyncNotifier<List<UserProfileModel>> {
  late final ChatRoomsRepository _chatRoomsRepo;

  @override
  FutureOr<List<UserProfileModel>> build() async {
    _chatRoomsRepo = ref.read(chatRoomsProvider);
    try {
      final result = await _chatRoomsRepo.getUsersInfo();
      final users = result.docs
          .map((doc) => UserProfileModel.fromJson(doc.data()))
          .toList();
      return users;
    } catch (e) {
      throw Exception('Failed to get users: ${e.toString()}');
    }
  }

  createChatroomId(String uid, String friendUid) {
    List<String> uids = [uid, friendUid];
    uids.sort();
    return "${uids[0]}_${uids[1]}";
  }

  Future<void> createChatroom(String uid, String friendUid) async {
    ref
        .read(chatRoomsProvider)
        .createChatroom(uid, friendUid, createChatroomId(uid, friendUid));
  }
}

final getUsersProvider =
    AsyncNotifierProvider<GetUsersViewModel, List<UserProfileModel>>(
  () => GetUsersViewModel(),
);
