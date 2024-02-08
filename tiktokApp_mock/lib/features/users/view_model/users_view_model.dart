import 'dart:async';

import 'package:TikTok/features/authentication/view_models/signup_view_model.dart';
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
    final signUpInfo = ref.read(signUpForm.notifier).state;

    final username = signUpInfo["username"] ?? "Anonymous"; // Default 값 설정
    final birthday =
        signUpInfo["birthday"] ?? ""; // 생일 정보가 없는 경우를 대비한 Default 값 설정
    if (credential.user == null) {
      throw Exception("Account creation failed. Please try again.");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      bio: "Undefined",
      link: "Undefined",
      email: credential.user!.email ?? "Anonymous@user.com",
      uid: credential.user!.uid,
      name: username,
      birthday: birthday,
    );

    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
