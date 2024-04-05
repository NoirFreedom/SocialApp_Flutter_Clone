import 'package:TikTok/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserProfileButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color fontColor;
  final VoidCallback? onPressed;

  const UserProfileButton({
    Key? key,
    required this.child,
    this.onPressed,
    required this.backgroundColor,
    required this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
        ),
        textStyle: TextStyle(
          fontSize: Sizes.size16,
          fontWeight: FontWeight.w600,
          color: fontColor,
        ),
      ),
      child: child,
    );
  }
}
