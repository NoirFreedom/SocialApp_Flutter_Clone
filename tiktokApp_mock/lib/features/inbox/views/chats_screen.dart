import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/inbox/views/chat_detail_screen.dart';
import 'package:TikTok/features/inbox/views/userList_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  late final Stream<QuerySnapshot> _chatroomsStream;

//! 초기화 필요
  @override
  void initState() {
    super.initState();
    _chatroomsStream =
        FirebaseFirestore.instance.collection('chat_rooms').snapshots();
  }

//! 대화방 추가
  void _addItem() {
    context.pushNamed(UserListScreen.routeName);
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(color: Colors.red.shade400, child: _makeTile(index)),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

//! chatroom id를 인자로 받아야 함
  void _onChatTap(int index) {
    context.pushNamed(ChatDetailScreen.routeName, params: {"chatId": "$index"});
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: const CircleAvatar(
        radius: 20,
        foregroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfDF8MHx8fDA%3D"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Message $index",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            "1h",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
      subtitle: const Text(
        "Chat messages would be here",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem, // 새 대화 추가 기능 구현 필요
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatroomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data['profileImageUrl'] ?? '기본 이미지 URL'),
                    ),
                    title: Text(data['name'] ?? '이름 없음'),
                    subtitle: Text(data['lastMessage'] ?? '마지막 메시지 없음'),
                    onTap: () {
                      // 대화방을 탭했을 때 상세 화면으로 이동하도록 구현
                    },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
