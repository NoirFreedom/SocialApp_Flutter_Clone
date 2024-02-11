import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnInfoChanged = void Function(String info);

class UserProfileInfo extends ConsumerStatefulWidget {
  final String? infoName;
  final VoidCallback? onTap;
  final OnInfoChanged? onInfoChanged;
  final StateProvider<String>? infoProvider;

  const UserProfileInfo({
    Key? key,
    this.infoName,
    this.onTap,
    this.onInfoChanged,
    this.infoProvider,
  }) : super(key: key);

  @override
  ConsumerState<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends ConsumerState<UserProfileInfo> {
  final TextEditingController _userInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userInfoController.addListener(() {
      setState(() {
        if (widget.onInfoChanged != null) {
          widget.onInfoChanged!(_userInfoController.text);
        }
      });
    });
  }

  @override
  void dispose() {
    _userInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hintText = widget.infoProvider != null
        ? ref.watch(widget.infoProvider!).isNotEmpty
            ? ref.watch(widget.infoProvider!)
            : widget.infoName
        : widget.infoName;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
        child: Row(
          children: [
            Text(
              "${widget.infoName}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Gaps.h16,
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: 258,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: TextField(
                      controller: _userInfoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
