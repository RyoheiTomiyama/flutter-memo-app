import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/player/player_seek_controller.dart';
import 'package:memo_app/provider/player_manager_provider.dart';
import 'package:memo_app/ui/player/player_controller_layout.dart';
import 'package:memo_app/ui/player/player_controller_playback.dart';

class PlayerController extends HookConsumerWidget {
  const PlayerController({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final playerManager = ref.watch(playerManagerProvider);
    final playerManagerNotifier = ref.watch(playerManagerProvider.notifier);

    if (playerManager.controller == null) {
      return Container();
    }

    final controller = playerManager.controller!;
    useListenable(controller);

    Widget buildHeader() {
      return Container();
    }

    Widget buildCenter() {
      return PlayerControllerPlayback(
        isPlay: controller.value.isPlaying,
        onPressed: () {
          controller.value.isPlaying
              ? playerManagerNotifier.pause()
              : playerManagerNotifier.play();
        },
      );
    }

    Widget buildFooter() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: PlayerSeekController(),
      );
    }

    return PlayerControllerLayout(
      buildHeader: buildHeader(),
      buildBody: buildCenter(),
      buildFooter: buildFooter(),
    );
  }
}
