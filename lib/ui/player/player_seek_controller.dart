import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player_manager.dart';
import 'package:memo_app/hooks/use_ticker.dart';
import 'package:video_player/video_player.dart';

class PlayerSeekController extends HookWidget {
  final VideoPlayerController controller;

  const PlayerSeekController({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final manager = PlayerManager(controller: controller);
    final width = useState(0.0);
    // 0.0 - 1.0
    final progress = useState(0.0);

    final shouldPlayAfterDrag = useState(false);

    final ticker = useTicker(Ticker((_) async {
      progress.value = await manager.progress;
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

    return GestureDetector(
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
      child: Material(
        color: Colors.grey.shade800.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: [
                Container(
                  // duration: controller.value.duration,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade800],
                      stops: [progress.value, progress.value],
                    ),
                    color: Colors.grey.shade900.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      manager.formatDuration(manager.position),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      manager.formatDuration(manager.duration),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
