import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/authentication/view_models/signup_view_model.dart';
import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:TikTok/features/users/repos/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

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
    const bio = "";
    const link = "";
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: bio,
      link: link,
      email: credential.user!.email ?? "Anonymous@user.com",
      uid: credential.user!.uid,
      name: username,
      birthday: birthday,
    );

    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> onUsernameUpdate(String username) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(name: username));
    await _userRepository.updateUser(state.value!.uid, {"name": username});
  }

  Future<void> onBioUpdate(String bio) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(bio: bio));
    await _userRepository.updateUser(state.value!.uid, {"bio": bio});
  }

  Future<void> onLinkUpdate(String link) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(link: link));
    await _userRepository.updateUser(state.value!.uid, {"link": link});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());

final usernameProvider = StateProvider<String>((ref) => '');
final bioProvider = StateProvider<String>((ref) => '');
final linkProvider = StateProvider<String>((ref) => '');
