import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/inbox/view_models/chats_screen_view_model.dart';
import 'package:TikTok/features/inbox/views/chat_detail_screen.dart';
import 'package:TikTok/features/inbox/views/userList_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  // final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  // final List<int> _items = [];

  // final Duration _duration = const Duration(milliseconds: 300);

  late final Stream<QuerySnapshot> _chatroomsStream;
  late final AuthenticationRepository _authRepository;
  late final Future<Map<String, dynamic>?> otherInfoFuture;

  // 대화방 목록을 가져오기
  @override
  void initState() {
    super.initState();
    _chatroomsStream =
        FirebaseFirestore.instance.collection('chat_rooms').snapshots();
    _authRepository = ref.read(authRepo);
    final currentUid = _authRepository.user!.uid;
    otherInfoFuture =
        ref.read(chatScreenProvider.notifier).getOtherInfo(currentUid);
  }

  void _onChatTap(
    String chatRoomId,
    String friendName,
  ) {
    context.pushNamed(ChatDetailScreen.routeName, params: {
      "chatId": chatRoomId,
    }, queryParams: {
      "friendName": friendName, // 쿼리 파라미터로 이름을 전달합니다.
    });
  }

  void _addItem() {
    context.pushNamed(UserListScreen.routeName);
  }

  // void _deleteItem(int index) {
  //   if (_key.currentState != null) {
  //     _key.currentState!.removeItem(
  //       index,
  //       (context, animation) => SizeTransition(
  //         sizeFactor: animation,
  //         child: Container(color: Colors.red.shade400, child: _makeTile(index)),
  //       ),
  //       duration: _duration,
  //     );
  //     _items.removeAt(index);
  //   }
  // }

  // Widget _makeTile(int index) {
  //   return ListTile(
  //     onLongPress: () => _deleteItem(index),
  //     onTap: () => _onChatTap(index),
  //     leading: const CircleAvatar(
  //       radius: 20,
  //       foregroundImage: NetworkImage(
  //           "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfDF8MHx8fDA%3D"),
  //     ),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Text(
  //           "Message $index",
  //           style: const TextStyle(fontWeight: FontWeight.w600),
  //         ),
  //         Text(
  //           "1h",
  //           style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
  //         ),
  //       ],
  //     ),
  //     subtitle: const Text(
  //       "Chat messages would be here",
  //       style: TextStyle(color: Colors.grey),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
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
                  print("data: $data");
                  return FutureBuilder(
                    future: otherInfoFuture,
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const ListTile(
                          leading: CircularProgressIndicator(),
                          title: Text('Loading...'),
                        );
                      }
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1713948774998-c94bfccd572a?q=80&w=3386&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        ),
                        title: Text(
                            asyncSnapshot.data!['name'] ?? 'Name not fount'),
                        subtitle: Text(data['lastMessage'] ?? '마지막 메시지 없음'),
                        onTap: () => _onChatTap("${document.id}_${data['uid']}",
                            asyncSnapshot.data!['name']),
                      );
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
