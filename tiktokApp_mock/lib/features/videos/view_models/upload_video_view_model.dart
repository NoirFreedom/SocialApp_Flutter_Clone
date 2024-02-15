import 'dart:async';

import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _videoRepository;

  @override
  FutureOr<void> build() {
    _videoRepository = ref.read(videoRepo);
  }

  Future<void> UploadVideo() async {}
}
