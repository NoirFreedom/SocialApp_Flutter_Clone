import 'dart:async';

import 'package:TikTok/features/inbox/repos/chatrooms_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUsersViewModel extends AsyncNotifier<void> {
  late final ChatRoomsRepository chatRoomsRepo;

  @override
  FutureOr build() {
    chatRoomsRepo = ref.read(chatRoomsProvider);
  }

  Future<void> getUsers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final users = await chatRoomsRepo.getUsersInfo();
        return users;
      },
    );
    print(state);
  }
}

final getUsersProvider = AsyncNotifierProvider<GetUsersViewModel, void>(
  () => GetUsersViewModel(),
);
