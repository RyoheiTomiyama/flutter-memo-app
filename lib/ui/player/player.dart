import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/hooks/player/video_player_controller_hooks.dart';
import 'package:memo_app/ui/player/player_controller.dart';
import 'package:memo_app/ui/player/player_viewer.dart';
import 'package:video_player/video_player.dart';

class Player extends HookWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    print('render');
    final videoPlayerController = useVideoPlayerController(
      VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    final initialize = useMemoized(() async {
      await videoPlayerController.initialize();
      videoPlayerController.setLooping(true);
      videoPlayerController.play();
      return true;
    }, []);

    final initializeSnapshot = useFuture(initialize);

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          PlayerViewer(controller: videoPlayerController),
          PlayerController(controller: videoPlayerController),
        ],
      ),
    );
  }
}
