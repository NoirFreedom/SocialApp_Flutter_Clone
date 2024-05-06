import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/inbox/view_models/chats_screen_view_model.dart';
import 'package:TikTok/features/inbox/views/chat_detail_screen.dart';
import 'package:TikTok/features/inbox/views/userList_screen.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';
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

  void _onChatTap(String chatRoomId, String friendName) {
    context.pushNamed(ChatDetailScreen.routeName, params: {
      "chatId": chatRoomId,
    }, queryParams: {
      "friendName": friendName, // 쿼리 파라미터로 이름을 전달합니다.
    });
    print("chatRoomId on chatScreen: $chatRoomId");
  }

  void _addItem() {
    context.pushNamed(UserListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(usersProvider.notifier);

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
                        leading: FutureBuilder(
                            future: userProfile.getUserAvatar(
                                "${asyncSnapshot.data!['uid']}.jpg"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data.toString()),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Icon(Icons.error);
                              }
                              return const Icon(Icons.account_circle);
                            }),
                        title: Text(
                            asyncSnapshot.data!['name'] ?? 'Name not fount'),
                        subtitle: Text(data['lastMessage'] ?? '마지막 메시지 없음'),
                        onTap: () => _onChatTap(
                            document.id, asyncSnapshot.data!['name']),
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
