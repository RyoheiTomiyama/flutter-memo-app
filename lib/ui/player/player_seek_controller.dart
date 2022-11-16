import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

extension DurationExt on Duration {
  String get format {
    final ss = inSeconds.remainder(60).toString().padLeft(2, '0');
    final mm = inMinutes.remainder(60).toString().padLeft(2, '0');
    final hh = inHours.remainder(60).toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }
}

class PlayerSeekController extends HookWidget {
  final VideoPlayerController controller;
  // %
  // final double progress;

  // 相対的に動画をシークする
  final void Function(double dseek)? seekBy;

  const PlayerSeekController(
      {super.key, required this.controller, this.seekBy});

  @override
  Widget build(BuildContext context) {
    final width = useState(0.0);
    final double progress = useMemoized(() {
      // print('2');
      if (!controller.value.isInitialized) {
        return 0;
      }
      final position = controller.value.position.inMilliseconds;
      final duration = controller.value.duration.inMilliseconds;
      return position / duration * 100;
    }, [controller.value.position, controller.value.duration]);

    final String duration = useMemoized(() {
      // print('1');
      if (!controller.value.isInitialized) {
        return '-:-';
      }
      final duration = controller.value.duration.format;
      return duration;
    }, [controller.value.position, controller.value.duration]);

    final String position = useMemoized(() {
      // print('1');
      if (!controller.value.isInitialized) {
        return '-:-';
      }
      final position = controller.value.position.format;
      return position;
    }, [controller.value.position, controller.value.duration]);

    return GestureDetector(
      onHorizontalDragStart: (details) {
        width.value = context.size?.width ?? 0;
        // print(details);
      },
      onHorizontalDragUpdate: (details) {
        // print(details);
        if (width.value > 0) {
          final dx = details.delta.dx;
          final dseek = dx / width.value;
          if (seekBy != null) seekBy!(dseek);
        }
      },
      onHorizontalDragEnd: (details) {
        // print(details);
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
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade800],
                      stops: [progress / 100, progress / 100],
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
                    Text(position, style: TextStyle(color: Colors.white)),
                    Text(duration, style: TextStyle(color: Colors.white)),
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
