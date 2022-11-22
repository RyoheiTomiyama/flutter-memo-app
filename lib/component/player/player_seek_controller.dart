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

    // 連続してSeekするとレンダリングが間に合わないから次のSeekをポジションを保管しておく
    final stackSeek = useState<Duration?>(null);

    final timer = useState<Timer?>(null);

    final dx = useState(0.0);

    final seekTo = useCallback((Duration position) async {
      dx.value = 0;
      await playerManagerNotifier.seekTo(position);
      progress.value = await playerManager.progress;
    }, []);

    // timerでSeekの頻度は抑えた
    final setTimer = useCallback((void Function() callback) {
      timer.value = Timer(const Duration(milliseconds: 80), callback);
    }, []);

    // stackSeekに積まれていたらSeekして、発火したことをtrueで返す
    final loadStackSeek = useCallback(() async {
      if (isMounted()) {
        // 積まれていたら
        if (stackSeek.value != null) {
          await seekTo(stackSeek.value!);
          stackSeek.value = null;
          return true;
        } else {
          isWait.value = false;
          return false;
        }
      }
      return false;
    }, [stackSeek.value]);

    nestedCheck() async {
      final isSeekCalled = await loadStackSeek();
      if (isSeekCalled) {
        // seekが実行された場合は次のタイマーを実行する
        isWait.value = true;
        setTimer(nestedCheck);
      }
    }

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
            if (timer.value != null) timer.value!.cancel();
            await seekTo(position);
            isWait.value = true;
            setTimer(nestedCheck);
          } else {
            stackSeek.value = position;
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
