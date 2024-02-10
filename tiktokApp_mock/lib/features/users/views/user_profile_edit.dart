import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';

import 'package:TikTok/features/users/views/widgets/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileEditScreen extends ConsumerWidget {
  static const String routeName = "userProfileEdit";
  static const String routeURL = "/userProfileEdit";

  const UserProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: Sizes.size4),
              child: TextButton(
                onPressed: () {}, //! Add functionality
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: Sizes.size16, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
        body: const Column(
          children: [
            Gaps.v32,
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1556139930-c23fa4a4f934?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            ),
            Gaps.v32,
            UserProfileInfo(infoName: "Username"),
            UserProfileInfo(infoName: "Pronouns"),
            UserProfileInfo(infoName: "Bio"),
            UserProfileInfo(infoName: "Link"),
          ],
        ));
  }
}
