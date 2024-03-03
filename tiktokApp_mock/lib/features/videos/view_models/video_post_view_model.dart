import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:TikTok/features/videos/views/video_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoPostState, String> {
  late final VideoRepository _videoRepository;
  late final _videoId;

  @override
  FutureOr<VideoPostState> build(String args) async {
    _videoId = args;
    _videoRepository = ref.read(videoRepo);
    final user = ref.read(authRepo).user;
    if (user != null) {
      final isLiked = await isLikedVideo();
      final likesCount = await fetchLikesCount(_videoId);
      return VideoPostState(isLiked: isLiked, likesCount: likesCount);
    } else {
      return VideoPostState(isLiked: false, likesCount: 0);
    }
  }

  Future<void> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
  }

  Future<bool> isLikedVideo(String videoId) async {
    final user = ref.read(authRepo).user;
    return _videoRepository.isLikedVideo(_videoId, user!.uid);
  }

  Future<int> fetchLikesCount(String videoId) async {
    return _videoRepository.fetchLikesCount(videoId);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
