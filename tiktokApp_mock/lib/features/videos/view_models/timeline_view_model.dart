import 'dart:async';

import 'package:TikTok/features/videos/models/video_model.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _videoRepository;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _videoRepository = ref.read(videoRepo);
    final result = await _videoRepository.fetchVideos();
    final newlist = result.docs.map((doc) => VideoModel.fromJson(doc.data()));
    _list = newlist.toList();

    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
        () => TimelineViewModel());
