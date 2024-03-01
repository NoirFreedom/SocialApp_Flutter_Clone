import 'dart:async';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepository _videoRepository;
  late final _videoId;

  @override
  FutureOr<void> build(String args) {
    _videoId = args;
    _videoRepository = ref.read(videoRepo);
  }

  Future<void> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    await _videoRepository.toggleLikeVideo(_videoId, user!.uid);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authRepo).user;
    return _videoRepository.isLikedVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
