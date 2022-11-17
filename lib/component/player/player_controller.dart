import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player_seek_controller.dart';
import 'package:memo_app/ui/player/player_controller_layout.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends HookWidget {
  final VideoPlayerController controller;
  const PlayerController({super.key, required this.controller});

  Widget buildHeader() {
    return Container();
  }

  Widget buildCenter() {
    return Container(
      child: IconButton(
        color: Colors.grey.shade800,
        iconSize: 80,
        icon: const Icon(Icons.play_arrow_rounded),
        onPressed: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PlayerSeekController(
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlayerControllerLayout(
      buildHeader: buildHeader,
      buildBody: buildCenter,
      buildFooter: buildFooter,
    );
  }
}
