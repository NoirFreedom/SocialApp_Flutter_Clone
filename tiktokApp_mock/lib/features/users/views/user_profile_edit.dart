import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';

import 'package:TikTok/features/users/views/widgets/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:TikTok/features/users/views/widgets/avatar.dart';

class UserProfileEditScreen extends ConsumerWidget {
  static const String routeName = "userProfileEdit";
  static const String routeURL = "/userProfileEdit";

  const UserProfileEditScreen({super.key});

  Future<void> _onPressedDone(BuildContext context, WidgetRef ref) async {
    final username = ref.read(usernameProvider);
    final bio = ref.read(bioProvider);
    final link = ref.read(linkProvider);

    // UsersViewModel의 인스턴스를 가져옵니다.
    final usersViewModel = ref.read(usersProvider.notifier);

    // UsersViewModel의 업데이트 메소드를 호출하여 데이터베이스를 업데이트
    await usersViewModel.onUsernameUpdate(username);
    await usersViewModel.onBioUpdate(bio);
    await usersViewModel.onLinkUpdate(link);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: Sizes.size4),
                  child: TextButton(
                    onPressed: () => _onPressedDone(context, ref),
                    child: const Text(
                      "Done",
                      style:
                          TextStyle(fontSize: Sizes.size16, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Gaps.v32,
                Gaps.v10,
                Avatar(
                  name: data.name,
                  hasAvatar: data.hasAvatar,
                  uid: data.uid,
                ),
                Gaps.v10,
                Gaps.v32,
                UserProfileInfo(
                  infoName: "Username",
                  onInfoChanged: (info) =>
                      ref.read(usernameProvider.notifier).state = info,
                  infoProvider: usernameProvider,
                ),
                UserProfileInfo(
                  infoName: "Bio",
                  onInfoChanged: (info) =>
                      ref.read(bioProvider.notifier).state = info,
                  infoProvider: bioProvider,
                ),
                UserProfileInfo(
                  infoName: "Link",
                  onInfoChanged: (info) =>
                      ref.read(linkProvider.notifier).state = info,
                  infoProvider: linkProvider,
                ),
              ],
            ),
          ),
        );
  }
}
