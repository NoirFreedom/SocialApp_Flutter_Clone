import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/models/%08video_post_state_model.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoPostStatus, String> {
  late final VideoRepository _videoRepository;
  late final _videoId;

  @override
  FutureOr<VideoPostStatus> build(String args) async {
    _videoId = args;
    _videoRepository = ref.read(videoRepo);
    final user = ref.read(authRepo).user;
    final isLiked = await ref.read(videoRepo).isLikedVideo(_videoId, user!.uid);
    final likesCount = await ref.read(videoRepo).fetchLikesCount(_videoId);
    print("isLiked: $isLiked");
    print("likesCount: $likesCount");

    state = AsyncValue.data(
        VideoPostStatus(isLiked: isLiked, likesCount: likesCount));
    return state.value!;
  }

  Future<int> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    bool isLiked = await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
    int likesCount = await ref.read(videoRepo).fetchLikesCount(_videoId);

    //! 수정 필요함(위 변수명과 아래 변수명이 일치하지 않으며, 토글기능을 수행중인지 확인 필요)
    if (isLiked) {
      final likesCount0 = likesCount + 1;
      return likesCount0;
    } else {
      if (_likeCounts > 0) {
        final likesCount0 = likesCount - 1;
        return likesCount0;
      }
    }

    state = AsyncValue.data(
        VideoPostStatus(isLiked: _isLiked, likesCount: _likeCounts));
    return state.value!.likesCount;
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoPostStatus, String>(
  () => VideoPostViewModel(),
);
