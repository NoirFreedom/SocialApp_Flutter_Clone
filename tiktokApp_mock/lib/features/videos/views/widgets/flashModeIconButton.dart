import 'package:TikTok/constants/sizes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeIconButton extends StatelessWidget {
  final FlashMode currentFlashMode;
  final FlashMode flashMode;
  final IconData icon;

  final VoidCallback onPressed;

  const FlashModeIconButton({
    super.key,
    required this.currentFlashMode,
    required this.flashMode,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: Sizes.size20,
      ),
      color: currentFlashMode == flashMode ? Colors.white : Colors.grey,
      onPressed: onPressed,
    );
  }
}
