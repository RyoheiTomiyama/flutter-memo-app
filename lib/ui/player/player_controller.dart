import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/ui/player/player_seek_controller.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends HookWidget {
  final VideoPlayerController controller;
  const PlayerController({super.key, required this.controller});

  buildHeader() {
    return Container();
  }

  buildCenter() {
    return Container(
      child: IconButton(
        color: Colors.grey.shade800,
        iconSize: 80,
        icon: const Icon(Icons.play_arrow_rounded),
        onPressed: () {},
      ),
    );
  }

  buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PlayerSeekController(
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('render controller');
    useListenable(controller);

    // final double progress = useMemoized(() {
    //   // print('2');
    //   if (!controller.value.isInitialized) {
    //     return 0;
    //   }
    //   final position = controller.value.position.inMilliseconds;
    //   final duration = controller.value.duration.inMilliseconds;
    //   return position / duration * 100;
    // }, [controller.value.position, controller.value.duration]);
    // final String duration = useMemoized(() {
    //   // print('1');
    //   if (!controller.value.isInitialized) {
    //     return '-:-';
    //   }
    //   final duration = controller.value.duration.format;
    //   return duration;
    // }, [controller.value.position, controller.value.duration]);
    // final String position = useMemoized(() {
    //   // print('1');
    //   if (!controller.value.isInitialized) {
    //     return '-:-';
    //   }
    //   final position = controller.value.position.format;
    //   return position;
    // }, [controller.value.position, controller.value.duration]);

    return Container(
      // color: Colors.amber,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(),
            buildCenter(),
            buildFooter(),
          ],
        ),
      ),
    );
  }
}
