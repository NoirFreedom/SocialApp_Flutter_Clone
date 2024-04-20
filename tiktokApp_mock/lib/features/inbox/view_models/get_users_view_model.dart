import 'dart:async';
import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUsersViewModel extends AsyncNotifier<List<Map<String, dynamic>>> {
  late final ChatRoomsRepository chatRoomsRepo;

  @override
  FutureOr<AsyncValue<List<Map<String, dynamic>>>> build() {
    chatRoomsRepo = ref.read(chatRoomsProvider);
    //! 값 리턴해야함
  }

  Future<void> getUsers() async {
    state = const AsyncLoading();
    try {
      final users = await chatRoomsRepo.getUsersInfo();
      state = AsyncValue.data(users);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
    print("state: $state");
  }
}

final getUsersProvider =
    AsyncNotifierProvider<GetUsersViewModel, List<Map<String, dynamic>>>(
  () => GetUsersViewModel(),
);
