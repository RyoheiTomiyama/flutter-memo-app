import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player_manager.dart';
import 'package:memo_app/hooks/use_ticker.dart';
import 'package:memo_app/ui/player/player_controller_progress.dart';
import 'package:video_player/video_player.dart';

class PlayerSeekController extends HookWidget {
  final VideoPlayerController controller;

  const PlayerSeekController({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final manager = PlayerManager(controller: controller);
    final isMounted = useIsMounted();
    final width = useState(0.0);
    // 0.0 - 1.0
    final progress = useState(0.0);

    final shouldPlayAfterDrag = useState(false);

    final ticker = useTicker(Ticker((_) async {
      if (isMounted()) {
        progress.value = await manager.progress;
      }
    }));

    useListenable(controller);

    useEffect(() {
      if (controller.value.isPlaying) {
        print('play');
        ticker.start();
      } else {
        print('stop');
        ticker.stop();
      }
    }, [controller.value.isPlaying]);

    return PlayerControllerProgress(
      progress: progress.value,
      currentTime: manager.formatDuration(manager.position),
      totalTime: manager.formatDuration(manager.duration),
      onHorizontalDragStart: (details) {
        width.value = context.size?.width ?? 0;
        shouldPlayAfterDrag.value = controller.value.isPlaying;
        manager.pause();
      },
      onHorizontalDragUpdate: (details) async {
        if (width.value > 0) {
          final dx = details.delta.dx;
          final dmicro = (dx / width.value) * manager.duration.inMicroseconds;
          final currentPosition = await manager.exactPosition ?? Duration.zero;
          final position = Duration(
            microseconds: currentPosition.inMicroseconds + dmicro.toInt(),
          );
          await manager.seekTo(position);
          progress.value = await manager.progress;
        }
      },
      onHorizontalDragEnd: (details) {
        if (shouldPlayAfterDrag.value) {
          manager.play();
        }
      },
    );
  }
}
