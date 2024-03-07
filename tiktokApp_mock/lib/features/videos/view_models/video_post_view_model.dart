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

  Future<void> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
    state = AsyncValue.data(
      VideoPostStatus(
        isLiked: !state.value!.isLiked, // 현재 상태의 반대로 설정
        likesCount: state.value!.isLiked
            ? state.value!.likesCount - 1
            : state.value!.likesCount + 1, // 좋아요 상태에 따라 수 조정
      ),
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoPostStatus, String>(
  () => VideoPostViewModel(),
);
