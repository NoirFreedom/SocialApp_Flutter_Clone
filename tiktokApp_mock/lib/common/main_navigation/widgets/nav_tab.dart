import 'package:TikTok/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TikTok/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: const Duration(
              milliseconds: 100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: isDarkMode(context) ? Colors.white : Colors.black54,
                  size: kIsWeb ? 30 : 18,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: isDarkMode(context) ? Colors.white : Colors.black54,
                    fontSize: kIsWeb ? 16 : 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
