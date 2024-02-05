import 'package:TikTok/generated/l10n.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();

  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.70,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).videoCommentCount(0, 0),
          ),
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    top: Sizes.size16,
                    bottom: Sizes.size96 + Sizes.size10,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Text(
                          "Img",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Sizes.size14,
                                  color: isDarkMode(context)
                                      ? Colors.grey.shade100
                                      : Colors.grey.shade900),
                            ),
                            Gaps.v1,
                            const Text(
                              "Where user leave their comment",
                              style: TextStyle(fontSize: Sizes.size14),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: isDarkMode(context)
                                ? Colors.grey.shade100
                                : Colors.black38,
                            size: Sizes.size20,
                          ),
                          Text(
                            "likes",
                            style: TextStyle(
                                color: isDarkMode(context)
                                    ? Colors.grey.shade100
                                    : Colors.black38,
                                fontSize: Sizes.size12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 20,
                      right: 16,
                      bottom: 32,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.white,
                          child: Text(
                            "Img",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              //! 아이콘이 unfocus될 때, animated 처리되지 않음
                              onTap: _onStartWriting,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              style: TextStyle(
                                color: isDarkMode(context)
                                    ? Colors.grey.shade100
                                    : Colors.black,
                              ),
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText:
                                    _isWriting ? null : "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: isDarkMode(context)
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size14,
                                ),
                                suffix: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 0,
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: _isWriting ? 1 : 0,
                                    duration: const Duration(milliseconds: 100),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.at,
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade800,
                                          size: 20,
                                        ),
                                        Gaps.h12,
                                        FaIcon(
                                          FontAwesomeIcons.gift,
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade800,
                                          size: 20,
                                        ),
                                        Gaps.h12,
                                        FaIcon(
                                          FontAwesomeIcons.faceSmile,
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade800,
                                          size: 20,
                                        ),
                                        Gaps.h12,
                                        if (_isWriting)
                                          GestureDetector(
                                            onTap: _stopWriting,
                                            child: FaIcon(
                                              FontAwesomeIcons.circleArrowUp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
