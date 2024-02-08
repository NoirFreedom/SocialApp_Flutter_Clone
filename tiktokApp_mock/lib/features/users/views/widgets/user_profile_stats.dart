import 'package:TikTok/constants/breakpoints.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserProfileStats extends StatelessWidget {
  const UserProfileStats({
    Key? key,
    required this.count,
    required this.title,
    required this.screenSize,
  }) : super(key: key);

  final String count;
  final String title;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    if (screenSize.width < Breakpoints.md) {
      return Column(
        children: [
          Text(count,
              style: const TextStyle(
                  fontSize: Sizes.size16, fontWeight: FontWeight.bold)),
          Gaps.v3,
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(count,
              style: const TextStyle(
                  fontSize: Sizes.size16, fontWeight: FontWeight.bold)),
          Gaps.h10,
          Text(
            title,
            style: TextStyle(
              fontSize: Sizes.size16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      );
    }
  }
}
