import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/models/%08video_post_state_model.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoPostStatus, String> {
  late final VideoRepository _videoRepository;
  late final _videoId;
  bool _isLiked = false; //! UI 업데이트를 위해 좋아요 상태를 false로 초기화
  int _likeCounts = 0; //! UI 업데이트를 위해 좋아요 수를 0으로 초기화

  @override
  FutureOr<VideoPostStatus> build(String args) async {
    _videoId = args;
    _videoRepository = ref.read(videoRepo);
    final user = ref.read(authRepo).user;
    final isLiked = await ref.read(videoRepo).isLikedVideo(_videoId, user!.uid);
    final likesCount = await ref.read(videoRepo).fetchLikesCount(_videoId);

    state = AsyncValue.data(
        VideoPostStatus(isLiked: isLiked, likesCount: likesCount));
    return state.value!;
  }

  Future<void> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    if (user != null) {
      await _videoRepository.toggleLikeVideo(_videoId, user.uid);
    }
    //! 즉각적인 UI 업데이트를 위해 좋아요 수를 증가 또는 감소 기능
    final isLiked = await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
    _isLiked = !_isLiked;
    if (_isLiked) {
      _likeCounts += 1;
    } else {
      if (_likeCounts > 0) {
        _likeCounts -= 1;
      }
    }

    state = AsyncValue.data(
        VideoPostStatus(isLiked: isLiked, likesCount: _likeCounts));
  }

  //! 사용 되지 않음
  Future<bool> isLikedVideo(String videoId) async {
    final user = ref.read(authRepo).user;
    return _videoRepository.isLikedVideo(_videoId, user!.uid);
  }

  //! 사용 되지 않음
  Future<int> fetchLikesCount(String videoId) async {
    return _videoRepository.fetchLikesCount(videoId);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoPostStatus, String>(
  () => VideoPostViewModel(),
);
