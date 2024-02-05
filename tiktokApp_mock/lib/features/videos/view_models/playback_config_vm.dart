import 'package:TikTok/features/videos/models/playback_config_model.dart';
import 'package:TikTok/features/videos/repos/playback_config_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoPlay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
