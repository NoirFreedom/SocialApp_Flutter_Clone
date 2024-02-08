import 'package:TikTok/constants/breakpoints.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final Size screenSize;

  PersistentTabBar({required this.screenSize});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
              color: isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.grey.shade200),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        labelColor: isDarkMode(context) ? Colors.grey.shade200 : Colors.black,
        tabs: [
          Padding(
            padding: screenSize.width < Breakpoints.md
                ? const EdgeInsets.symmetric(horizontal: Sizes.size52)
                : const EdgeInsets.symmetric(horizontal: 200),
            child: const Icon(Icons.grid_on_outlined),
          ),
          Padding(
            padding: screenSize.width < Breakpoints.md
                ? const EdgeInsets.symmetric(horizontal: Sizes.size52)
                : const EdgeInsets.symmetric(horizontal: 200),
            child: const FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // oldDelegate를 PersistentTabBar 타입으로 캐스팅합니다.
    final PersistentTabBar oldTabBarDelegate = oldDelegate as PersistentTabBar;
    // 이전 screenSize와 현재 screenSize를 비교합니다.
    return oldTabBarDelegate.screenSize != screenSize;
  }
}
