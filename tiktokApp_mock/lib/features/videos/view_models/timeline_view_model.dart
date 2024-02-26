import 'dart:async';

import 'package:TikTok/features/videos/models/video_model.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _videoRepository;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetVideos({int? lastItemCreatedAt}) async {
    final result = await _videoRepository.fetchVideos(
        lastItemCreatedAt: lastItemCreatedAt);
    final videos = result.docs
        .map((doc) => VideoModel.fromJson(json: doc.data(), videoId: doc.id));
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _videoRepository = ref.read(videoRepo);
    _list = await _fetVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
        () => TimelineViewModel());
