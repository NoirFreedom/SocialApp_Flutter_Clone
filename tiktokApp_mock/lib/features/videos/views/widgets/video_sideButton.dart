import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  bool isLiked;

  VideoButton({
    super.key,
    required this.icon,
    required this.text,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v28,
        FaIcon(
          icon,
          color: isLiked ? Colors.red.shade300 : Colors.white,
          size: Sizes.size28,
        ),
        Gaps.v10,
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
