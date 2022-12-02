import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/application/gallery/interactor_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/interface/gallery/repository_gallery.dart';
import 'package:video_player/video_player.dart';

part 'player_manager.freezed.dart';

@freezed
class PlayerManagerState with _$PlayerManagerState {
  const PlayerManagerState._();

  const factory PlayerManagerState({
    @Default(null) VideoPlayerController? controller,
    // Seekバーをドラッグ中はtrueにする
    @Default(false) bool isSeeking,
    @Default(null) File? file,
    @Default(null) Gallery? gallery,
  }) = _PlayerManagerState;

  bool get isInitialized {
    return controller?.value.isInitialized ?? false;
  }

  Duration get duration {
    if (!isInitialized) {
      return Duration.zero;
    }
    return controller!.value.duration;
  }

  Duration get position {
    if (!isInitialized) {
      return Duration.zero;
    }
    return controller!.value.position;
  }

  Future<Duration?> get exactPosition async {
    if (!isInitialized) {
      return Duration.zero;
    }
    return controller!.position;
  }

  Future<double> get progress async {
    final pos = await exactPosition ?? Duration.zero;
    return pos.inMilliseconds / duration.inMilliseconds;
  }
}

class PlayerManagerModel extends StateNotifier<PlayerManagerState> {
  PlayerManagerModel() : super(const PlayerManagerState());
  final galleryInteractor = InteractorGallery(RepositoryGallery());

  void addController(VideoPlayerController con) {
    state = state.copyWith(controller: con);
  }

  Future<void> initializeController({bool loop = true}) async {
    final _controller = state.controller;
    if (_controller == null) {
      log('not found controller');
      return;
    }
    if (!_controller.value.isInitialized) {
      await _controller.initialize();
      _controller.setLooping(loop);
    }
  }

  Future<void> pause() async {
    if (!state.isInitialized || !state.controller!.value.isPlaying) {
      return;
    }
    return state.controller!.pause();
  }

  Future<void> play() async {
    if (!state.isInitialized || state.controller!.value.isPlaying) {
      print('${state.isInitialized}');
      return;
    }
    return state.controller!.play();
  }

  String formatDuration(Duration duration) {
    if (!state.isInitialized) {
      return '--:--';
    }
    final ss = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final mm = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hh = duration.inHours.remainder(60).toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  Future<void> seekTo(Duration position) async {
    if (!state.isInitialized) {
      return;
    }
    // video_playerのiOSの実装を見るとseekToで描画完了まで待てていないようTODOにはなっていた
    await state.controller!.seekTo(position);
  }

  void setSeeking(bool b) {
    if (state.isSeeking != b) {
      state = state.copyWith(isSeeking: b);
    }
  }

  Future<File> getFileById(String id) async {
    final file = await galleryInteractor.getFileById(id);
    state = state.copyWith(file: file);
    return file;
  }

  Future<Gallery> getGalleryById(String id) async {
    final gallery = await galleryInteractor.getGalleryById(id);
    state = state.copyWith(gallery: gallery);
    return gallery;
  }

  @override
  void dispose() {
    state.controller?.dispose();
    super.dispose();
  }
}
