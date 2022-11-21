import 'dart:async';

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
      final newProgress = await playerManager.progress;
      if (isMounted()) {
        progress.value = newProgress;
      }
    }));

    useEffect(() {
      if (controller.value.isPlaying) {
        ticker.start();
      } else {
        ticker.stop();
      }
      return null;
    }, [controller.value.isPlaying]);

    final isWait = useState(false);

    final timer = useState<Timer?>(null);

    final dx = useState(0.0);

    // timerでSeekの頻度は抑えた
    // TODO 最後のseekが動いてくようにストックする容器を用意する
    final setTimer = useCallback(() {
      return Timer.periodic(const Duration(milliseconds: 33), (timer) {
        if (isMounted()) {
          isWait.value = false;
        }
      });
    }, []);

    return PlayerControllerProgress(
      progress: progress.value,
      currentTime: playerManagerNotifier.formatDuration(playerManager.position),
      totalTime: playerManagerNotifier.formatDuration(playerManager.duration),
      onHorizontalDragStart: (details) {
        width.value = context.size?.width ?? 0;
        shouldPlayAfterDrag.value = controller.value.isPlaying;
        playerManagerNotifier.pause();
        playerManagerNotifier.setSeeking(true);
      },
      onHorizontalDragUpdate: (details) async {
        if (width.value > 0) {
          dx.value += details.delta.dx;
          final dmicro =
              (dx.value / width.value) * playerManager.duration.inMicroseconds;
          final currentPosition =
              await playerManager.exactPosition ?? Duration.zero;
          final position = Duration(
            microseconds: currentPosition.inMicroseconds + dmicro.toInt(),
          );
          if (!isWait.value) {
            print(DateTime.now());
            if (timer.value != null) timer.value!.cancel();
            dx.value = 0;
            isWait.value = true;
            await playerManagerNotifier.seekTo(position);
            timer.value = setTimer();
            progress.value = await playerManager.progress;
          }
        }
      },
      onHorizontalDragEnd: (details) {
        playerManagerNotifier.setSeeking(false);
        if (shouldPlayAfterDrag.value) {
          playerManagerNotifier.play();
        }
      },
    );
  }
}
