import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/hooks/player/video_player_controller_hooks.dart';
import 'package:video_player/video_player.dart';

class Player extends HookWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    print('render');
    final videoPlayerController = useVideoPlayerController(
      VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );

    final chewieController = useState<ChewieController?>(null);

    final initialize = useMemoized(() async {
      await videoPlayerController.initialize();
      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        zoomAndPan: true,
      );
      return true;
    }, []);

    final initializeSnapshot = useFuture(initialize);

    if (initializeSnapshot.hasData) {
      return Chewie(
        controller: chewieController.value!,
      );
    }
    return Container();
  }
}