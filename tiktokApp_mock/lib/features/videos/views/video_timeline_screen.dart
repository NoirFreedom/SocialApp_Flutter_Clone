import 'package:TikTok/features/videos/view_models/timeline_view_model.dart';
import 'package:TikTok/features/videos/views/video_post.dart';
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
  int _itemCount = 0;

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
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
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
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              color: Colors.blueGrey,
              displacement: 50.0,
              edgeOffset: 50,
              onRefresh: _onRefresh,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                      onVideoFinished: _onVideoFinished,
                      index: index,
                      videoData: videoData);
                },
              ),
            );
          },
        );
  }
}
