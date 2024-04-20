import 'package:TikTok/features/inbox/view_models/get_users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerStatefulWidget {
  static const String routeName = "userList";
  static const String routeURL = "/userList";
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    final users = ref.read(getUsersProvider);
    print("user: $users");

    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("User $index"),
            onTap: () {
              // Navigate to chat screen
            },
          );
        },
      ),
    );
  }
}
