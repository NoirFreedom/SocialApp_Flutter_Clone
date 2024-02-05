import 'package:TikTok/features/inbox/activity_screen.dart';
import 'package:TikTok/features/inbox/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onDmPreseed() {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTap() {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("inbox"),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
            onPressed: _onDmPreseed,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: _onActivityTap,
            title: const Text(
              "Activity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 16),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: const Text(
              "New followers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("0 new notifications",
                style: TextStyle(fontSize: 12)),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 16),
          ),
        ],
      ),
    );
  }
}
