import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = "activity";
  static const String routeURL = "/activity";
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    },
  ];

  bool _showBarrier = false;

  final List<String> _notifications =
      List.generate(10, (index) => "${index}h ago");

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: const Offset(0, 0),
  ).animate(_animationController);

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black.withOpacity(0.5),
  ).animate(_animationController);

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  void _onDissmissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h6,
              RotationTransition(
                  turns: _arrowAnimation,
                  child: const FaIcon(FontAwesomeIcons.chevronDown, size: 12)),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Text(
                  "New",
                  style: TextStyle(fontSize: Sizes.size14, color: Colors.grey),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDissmissed(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green.shade400,
                    child: const Padding(
                      padding: EdgeInsets.only(left: Sizes.size16),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red.shade400,
                    child: const Padding(
                      padding: EdgeInsets.only(right: Sizes.size16),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isDarkMode(context)
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade400),
                          shape: BoxShape.circle,
                          color: isDarkMode(context)
                              ? Colors.grey.shade800
                              : Colors.white),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode(context)
                                ? Colors.grey.shade200
                                : Colors.grey.shade800),
                        children: [
                          const TextSpan(
                            text: " New features are coming soon!",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: " $notification",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    trailing:
                        const FaIcon(FontAwesomeIcons.chevronRight, size: 16),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    Sizes.size5,
                  ),
                  bottomRight: Radius.circular(
                    Sizes.size5,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            tab["icon"],
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
