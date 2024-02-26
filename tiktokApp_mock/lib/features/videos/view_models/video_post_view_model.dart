import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepository _videoRepository;
  late final _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _videoRepository = ref.read(videoRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _videoRepository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
