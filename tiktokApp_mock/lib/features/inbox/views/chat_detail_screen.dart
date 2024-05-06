import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/inbox/view_models/messages_view_model.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;
  final String friendName;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.friendName,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  late final Stream<QuerySnapshot> _chatStream;

  @override
  void initState() {
    super.initState();
    _chatStream =
        FirebaseFirestore.instance.collection('chat_rooms').snapshots();
  }

  @override
  void dispose() {
    // 사용이 끝났을 때 FocusNode를 해제
    _focusNode.dispose();
    super.dispose();
  }

  // 텍스트 필드 포커스 해제
  void _unfocusTextField() {
    _focusNode.unfocus();
  }

  void _onSendPressed() {
    final text = _textEditingController.text;
    if (text.isEmpty) {
      return;
    }
    ref
        .read(messagesProvider(widget.chatId).notifier)
        .sendMessage(text, widget.chatId);
    _textEditingController.clear();
    print("chatRoomId on chat_detail_screen: ${widget.chatId}");
  }

  void _deleteMessagePrompt(int createdAt, String chatRoomId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 대화상자 닫기
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // 대화상자 닫기
                // 메시지 삭제 로직 호출
                await ref
                    .read(messagesProvider(widget.chatId).notifier)
                    .deleteMessage(createdAt, chatRoomId);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider(widget.chatId)).isLoading;
    final String friendUid = widget.chatId.split("_").first;
    final uid = ref.watch(authRepo).user!.uid;
    print(uid);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: FutureBuilder(
            future: ref
                .read(usersProvider.notifier)
                .getUserAvatar("$friendUid.jpg"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Stack(
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(snapshot.data as String),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: Sizes.size10,
                        width: Sizes.size10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: isDarkMode(context)
                                  ? Colors.grey.shade900
                                  : Colors.white,
                              width: 1.5),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const CircleAvatar(
                    child: Icon(Icons.error_outline)); // 에러가 발생했을 경우
              }
              return const CircleAvatar(
                  child: CircularProgressIndicator()); // 로딩 중
            },
          ),
          title: Text(
            widget.friendName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: const Text("Active Now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color:
                    isDarkMode(context) ? Colors.grey.shade100 : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color:
                    isDarkMode(context) ? Colors.grey.shade100 : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
        elevation: 1,
      ),
      body: StreamBuilder(
        stream: _chatStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Ensure that snapshot.data is not null and is of type QuerySnapshot
          final querySnapshot = snapshot.data;
          if (querySnapshot == null) {
            return const Center(child: Text("No data found"));
          }
          return GestureDetector(
            onTap: _unfocusTextField,
            child: Stack(
              children: [
                ref.watch(chatProvider(widget.chatId)).when(
                      data: (data) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final message = data[index];

                            final isMine =
                                message.userId == ref.watch(authRepo).user!.uid;
                            if (isMine) {
                              return GestureDetector(
                                onLongPress: () {
                                  print("message: ${message.createdAt}");
                                  _deleteMessagePrompt(
                                      message.createdAt, widget.chatId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size16,
                                      vertical: Sizes.size8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Sizes.size8,
                                                      vertical: Sizes.size4),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                Sizes.size8),
                                                        topRight:
                                                            Radius.circular(
                                                                Sizes.size8),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                Sizes.size8)),
                                              ),
                                              child: Text(
                                                message.text,
                                                style: TextStyle(
                                                    fontSize: Sizes.size16,
                                                    color:
                                                        Colors.grey.shade900),
                                              ),
                                            ),
                                            Gaps.v4,
                                            Text(
                                              "12:0$index PM",
                                              style: const TextStyle(
                                                  fontSize: Sizes.size12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gaps.h16,
                                      // 내가 보낸 메시지
                                      FutureBuilder(
                                        future: ref
                                            .read(usersProvider.notifier)
                                            .getUserAvatar(uid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            return CircleAvatar(
                                              foregroundImage: NetworkImage(
                                                  snapshot.data as String),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const CircleAvatar(
                                                child: Icon(Icons
                                                    .error_outline)); // 에러가 발생했을 경우
                                          }
                                          return const CircleAvatar(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            // 상대방이 보낸 메시지
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size16,
                                  vertical: Sizes.size8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: ref
                                        .read(usersProvider.notifier)
                                        .getUserAvatar("$friendUid.jpg"),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return CircleAvatar(
                                          foregroundImage: NetworkImage(
                                              snapshot.data as String),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const CircleAvatar(
                                            child: Icon(Icons
                                                .error_outline)); // 에러가 발생했을 경우
                                      }
                                      return const CircleAvatar(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                  Gaps.h16,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Sizes.size8,
                                              vertical: Sizes.size4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Sizes.size8),
                                                    topRight: Radius.circular(
                                                        Sizes.size8),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Sizes.size8)),
                                          ),
                                          child: Text(
                                            message.text,
                                            style: TextStyle(
                                                fontSize: Sizes.size16,
                                                color: Colors.grey.shade900),
                                          ),
                                        ),
                                        Gaps.v4,
                                        Text(
                                          "12:0$index PM",
                                          style: const TextStyle(
                                              fontSize: Sizes.size12,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gaps.h10,
                          itemCount: data.length,
                        );
                      },
                      error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(
            top: Sizes.size10, left: Sizes.size20, right: Sizes.size20),
        color:
            isDarkMode(context) ? Colors.grey.shade800 : Colors.grey.shade100,
        child: SizedBox(
          height: Sizes.size52,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: Sizes.size16, horizontal: Sizes.size16),
                    filled: true,
                    fillColor: isDarkMode(context)
                        ? Colors.grey.shade900
                        : Colors.white,
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffix: Transform.translate(
                        offset: const Offset(0, 2),
                        child: const FaIcon(FontAwesomeIcons.faceSmile)),
                  ),
                ),
              ),
              Gaps.h16,
              Container(
                padding: const EdgeInsets.all(Sizes.size3),
                decoration: BoxDecoration(
                  color:
                      isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: isLoading ? null : _onSendPressed,
                  icon: FaIcon(
                    isLoading
                        ? FontAwesomeIcons.spinner
                        : FontAwesomeIcons.paperPlane,
                    color: isDarkMode(context)
                        ? Colors.grey.shade200
                        : Colors.grey.shade900,
                    size: Sizes.size20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
