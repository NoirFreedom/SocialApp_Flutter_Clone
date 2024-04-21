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
      print("users: $users");
      return users;
    } catch (e) {
      throw Exception('Failed to get users: ${e.toString()}');
    }
  }
}

final getUsersProvider =
    AsyncNotifierProvider<GetUsersViewModel, List<UserProfileModel>>(
  () => GetUsersViewModel(),
);
