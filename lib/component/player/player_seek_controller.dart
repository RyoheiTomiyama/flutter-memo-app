import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/hooks/use_ticker.dart';
import 'package:memo_app/provider/player_manager_provider.dart';
import 'package:memo_app/ui/player/player_controller_progress.dart';

class PlayerSeekController extends HookConsumerWidget {
  const PlayerSeekController({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final playerManager = ref.watch(playerManagerProvider);
    final playerManagerNotifier = ref.watch(playerManagerProvider.notifier);

    if (playerManager.controller == null) {
      return Container();
    }

    final controller = playerManager.controller!;
    useListenable(controller);

    final isMounted = useIsMounted();
    final width = useState(0.0);
    // 0.0 - 1.0
    final progress = useState(0.0);

    final shouldPlayAfterDrag = useState(false);

    final ticker = useTicker(Ticker((_) async {
      if (isMounted()) {
        progress.value = await playerManager.progress;
      }
    }));

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
      currentTime: playerManagerNotifier.formatDuration(playerManager.position),
      totalTime: playerManagerNotifier.formatDuration(playerManager.duration),
      onHorizontalDragStart: (details) {
        width.value = context.size?.width ?? 0;
        shouldPlayAfterDrag.value = controller.value.isPlaying;
        playerManagerNotifier.pause();
      },
      onHorizontalDragUpdate: (details) async {
        if (width.value > 0) {
          final dx = details.delta.dx;
          final dmicro =
              (dx / width.value) * playerManager.duration.inMicroseconds;
          final currentPosition =
              await playerManager.exactPosition ?? Duration.zero;
          final position = Duration(
            microseconds: currentPosition.inMicroseconds + dmicro.toInt(),
          );
          await playerManagerNotifier.seekTo(position);
          progress.value = await playerManager.progress;
        }
      },
      onHorizontalDragEnd: (details) {
        if (shouldPlayAfterDrag.value) {
          playerManagerNotifier.play();
        }
      },
    );
  }
}
