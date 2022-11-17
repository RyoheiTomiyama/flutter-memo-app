import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/player/player_seek_controller.dart';
import 'package:memo_app/provider/player_manager_provider.dart';
import 'package:memo_app/ui/player/player_controller_layout.dart';

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
            controller.value.isPlaying
                ? playerManagerNotifier.pause()
                : playerManagerNotifier.play();
          },
        ),
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
