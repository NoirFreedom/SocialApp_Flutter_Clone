import 'dart:async';

import 'package:TikTok/features/videos/models/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  Future<void> uploadVideo(String title, String description) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    // final newVideo = VideoModel(
    //   title: title,
    //   description: description,
    //   comments: 0,
    //   likes: 0,
    //   creatorAt: 0,
    //   creatorUid: "",
    //   thumbnailUrl: "",
    //   videoUrl: "",
    //   creator: "",
    // );
    _list = [..._list];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
        () => TimelineViewModel());
