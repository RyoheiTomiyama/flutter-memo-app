import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController useVideoPlayerController(initialValue) {
  return use(VideoPlayerControllerHook(initialValue));
}

class VideoPlayerControllerHook extends Hook<VideoPlayerController> {
  final VideoPlayerController initialValue;

  const VideoPlayerControllerHook(this.initialValue);

  @override
  HookState<VideoPlayerController, Hook<VideoPlayerController>> createState() =>
      VideoPlayerControllerHookState();
}

class VideoPlayerControllerHookState
    extends HookState<VideoPlayerController, VideoPlayerControllerHook> {
  late VideoPlayerController controller;

  @override
  void initHook() {
    super.initHook();
    controller = hook.initialValue;
  }

  @override
  VideoPlayerController build(BuildContext context) {
    return controller;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
