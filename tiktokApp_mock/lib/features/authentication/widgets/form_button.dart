import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:TikTok/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: disabled
                ? isDarkMode(context)
                    ? Colors.grey.shade700
                    : Colors.grey.shade400
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Sizes.size20)),
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
                color: disabled ? Colors.grey.shade500 : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            child: const Text(
              "Next",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
