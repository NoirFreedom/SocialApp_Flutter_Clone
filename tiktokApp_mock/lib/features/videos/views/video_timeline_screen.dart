import 'package:TikTok/features/videos/view_models/timeline_vm.dart';
import 'package:TikTok/features/videos/views/widgets/video_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final Duration _scrollDuration = const Duration(milliseconds: 200);
  final Curve _scrollCurve = Curves.linear;
  final PageController _pageController = PageController();
  int _itemCount = 4;

  void _onVideoFinished() {
    return;
  }

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (error, stack) => Center(
              child: Text(
            "Error: $error",
            style: const TextStyle(color: Colors.black),
          )),
          data: (videos) => RefreshIndicator(
            color: Colors.blueGrey,
            displacement: 50.0,
            edgeOffset: 50,
            onRefresh: _onRefresh,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) =>
                  VideoPost(onVideoFinished: _onVideoFinished, index: index),
            ),
          ),
        );
  }
}
