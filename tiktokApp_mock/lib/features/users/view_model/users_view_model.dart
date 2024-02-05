import 'dart:async';

import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account creation failed. Please try again.");
    }
    state = AsyncValue.data(
      UserProfileModel(
          bio: "Undefined",
          link: "Undefined",
          email: credential.user!.email ?? "Anonymous@user.com",
          uid: credential.user!.uid,
          name: credential.user!.displayName ?? "Anonymous"),
    );
  }
}

final usersProvider = AsyncNotifierProvider(() => UserViewModel());
