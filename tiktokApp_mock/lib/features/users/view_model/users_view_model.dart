import 'dart:async';

import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:TikTok/features/users/repos/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account creation failed. Please try again.");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
        bio: "Undefined",
        link: "Undefined",
        email: credential.user!.email ?? "Anonymous@user.com",
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "Anonymous");
    await _repository.createProfile(profile);
    state = AsyncValue.data(
      profile,
    );
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
