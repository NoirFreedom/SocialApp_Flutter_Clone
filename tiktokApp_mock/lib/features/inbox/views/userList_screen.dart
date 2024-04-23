import 'package:TikTok/features/inbox/view_models/get_users_view_model.dart';
import 'package:TikTok/features/inbox/views/chat_detail_screen.dart';
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
  void createChatroomWith(String uid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatDetailScreen(chatId: uid)));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getUsersProvider).when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => Center(child: Text("$error")),
        data: (users) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("User List"),
            ),
            body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  onTap: () {
                    createChatroomWith(users[index].uid);
                  },
                );
              },
            ),
          );
        });
  }
}
