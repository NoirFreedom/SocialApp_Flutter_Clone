import 'dart:async';
import 'dart:io';

import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';
import 'package:TikTok/features/videos/models/video_model.dart';
import 'package:TikTok/features/videos/repos/videos_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _videoRepository;

  @override
  FutureOr<void> build() {
    _videoRepository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, String title, String description,
      BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final task = await _videoRepository.uploadVideoFile(video, user!.uid);
          if (task.metadata != null) {
            await _videoRepository.saveVideo(VideoModel(
                title: title,
                description: description,
                videoUrl: await task.ref.getDownloadURL(),
                thumbnailUrl: "",
                likes: 0,
                comments: 0,
                creatorUid: user.uid,
                creatorAt: DateTime.now().millisecondsSinceEpoch,
                creator: userProfile.name));
          }
        },
      );
      context.pushReplacement("/home");
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
