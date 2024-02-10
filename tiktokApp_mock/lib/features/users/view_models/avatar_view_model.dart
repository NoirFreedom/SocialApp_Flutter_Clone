import 'dart:async';
import 'dart:io';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/users/repos/user_repo.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();

    final filename = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(file, filename);
      ref.read(usersProvider.notifier).onAvatarUpload();
    });
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
