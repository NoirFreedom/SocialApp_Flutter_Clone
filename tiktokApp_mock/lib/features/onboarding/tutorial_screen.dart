import 'package:TikTok/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const PageFirst(),
              secondChild: const PageSecond(),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 100),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
                left: Sizes.size24,
                right: Sizes.size24),
            child: AnimatedOpacity(
              opacity: _showingPage == Page.first ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: CupertinoButton(
                onPressed: _onEnterAppTap,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: const Text(
                  "Enter the App",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PageSecond extends StatelessWidget {
  const PageSecond({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        Text(
          'Follow the Rules!',
          style: TextStyle(fontSize: 31, fontWeight: FontWeight.w800),
        ),
        Gaps.v20,
        Text(
          "Please make sure that you have read all the terms.",
          style: TextStyle(
            fontSize: Sizes.size16,
          ),
        ),
      ],
    );
  }
}

class PageFirst extends StatelessWidget {
  const PageFirst({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        const Text(
          'Watch this Cool Videos!',
          style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w800),
        ),
        Gaps.v20,
        const Text(
          'Videos are personalized for you based on what you watch, like, and share.',
          style: TextStyle(
            fontSize: Sizes.size16,
          ),
        ),
        Gaps.v96,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Swipe left to go the next page",
              style: TextStyle(fontSize: Sizes.size16),
            ),
            Gaps.h10,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                shape: BoxShape.circle,
              ),
              child: const FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
