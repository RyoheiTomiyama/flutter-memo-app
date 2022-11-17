import 'package:video_player/video_player.dart';

abstract class IPlayerManager {
  Future<void> play();
  Future<void> pause();
  Duration get duration;
  Duration get position; // 500msごとの位置
  String formatDuration(Duration duration);
  Future<Duration?> get exactPosition;
  Future<double> get progress; // 0.0 -- 1.0
}

class PlayerManager implements IPlayerManager {
  VideoPlayerController controller;

  PlayerManager({required this.controller});

  @override
  Duration get duration {
    return controller.value.duration;
  }

  @override
  Duration get position {
    return controller.value.position;
  }

  @override
  Future<Duration?> get exactPosition async {
    return controller.position;
  }

  @override
  Future<double> get progress async {
    final pos = await exactPosition ?? Duration.zero;
    return pos.inMilliseconds / duration.inMilliseconds;
  }

  @override
  Future<void> pause() async {
    if (!controller.value.isPlaying) {
      return;
    }
    return controller.pause();
  }

  @override
  Future<void> play() async {
    if (controller.value.isPlaying) {
      return;
    }
    return controller.play();
  }

  @override
  String formatDuration(Duration duration) {
    if (!controller.value.isInitialized) {
      return '--:--';
    }
    final ss = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final mm = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hh = duration.inHours.remainder(60).toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }
}
