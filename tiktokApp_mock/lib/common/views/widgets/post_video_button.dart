import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 12,
          child: Container(
            height: 30,
            width: 25,
            decoration: BoxDecoration(
              color: isDarkMode(context) ? Colors.white : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(Sizes.size12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          ),
        ),
        Positioned(
          left: 12,
          child: Container(
            height: 30,
            width: 25,
            decoration: BoxDecoration(
              color: isDarkMode(context) ? Colors.white : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(Sizes.size12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          decoration: BoxDecoration(
              color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
              borderRadius: BorderRadius.circular(25)),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
