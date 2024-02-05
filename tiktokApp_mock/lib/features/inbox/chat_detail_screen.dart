import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            children: [
              const CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfDF8MHx8fDA%3D"),
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
                  )),
            ],
          ),
          title: Text(
            "User Name (${widget.chatId})",
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
      body: GestureDetector(
        onTap: _unfocusTextField,
        child: Stack(
          children: [
            ListView.separated(
              itemBuilder: (context, index) {
                var isMine = index % 2 == 0;

                if (isMine) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size16, vertical: Sizes.size8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size8,
                                    vertical: Sizes.size4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(Sizes.size8),
                                      topRight: Radius.circular(Sizes.size8),
                                      bottomLeft: Radius.circular(Sizes.size8)),
                                ),
                                child: Text(
                                  "Hey",
                                  style: TextStyle(
                                      fontSize: Sizes.size16,
                                      color: Colors.grey.shade900),
                                ),
                              ),
                              Gaps.v4,
                              Text(
                                "12:0$index PM",
                                style: const TextStyle(
                                    fontSize: Sizes.size12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Gaps.h16,
                        const CircleAvatar(
                          foregroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1528892952291-009c663ce843?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTZ8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D"),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16, vertical: Sizes.size8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        foregroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfDF8MHx8fDA%3D"),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size8,
                                  vertical: Sizes.size4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(Sizes.size8),
                                    topRight: Radius.circular(Sizes.size8),
                                    bottomRight: Radius.circular(Sizes.size8)),
                              ),
                              child: Text(
                                "what's up?",
                                style: TextStyle(
                                    fontSize: Sizes.size16,
                                    color: Colors.grey.shade900),
                              ),
                            ),
                            Gaps.v4,
                            Text(
                              "12:0$index PM",
                              style: const TextStyle(
                                  fontSize: Sizes.size12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Gaps.h10,
              itemCount: 10,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                padding: const EdgeInsets.only(
                    top: Sizes.size10, left: Sizes.size20, right: Sizes.size20),
                color: isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
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
                                vertical: Sizes.size16,
                                horizontal: Sizes.size16),
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
                                child:
                                    const FaIcon(FontAwesomeIcons.faceSmile)),
                          ),
                        ),
                      ),
                      Gaps.h16,
                      Container(
                        padding: const EdgeInsets.all(Sizes.size14),
                        decoration: BoxDecoration(
                          color: isDarkMode(context)
                              ? Colors.grey.shade900
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: isDarkMode(context)
                              ? Colors.grey.shade200
                              : Colors.grey.shade900,
                          size: Sizes.size18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
