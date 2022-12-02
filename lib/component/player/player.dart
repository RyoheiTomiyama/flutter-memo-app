import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/player/player_controller.dart';
import 'package:memo_app/provider/player_manager_provider.dart';
import 'package:memo_app/ui/player/player_viewer.dart';
import 'package:video_player/video_player.dart';

class Player extends HookConsumerWidget {
  final String id;
  const Player({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    // print('render');

    final playerManager = ref.watch(playerManagerProvider);
    final playerManagerNotifier = ref.watch(playerManagerProvider.notifier);

    final getFile = useMemoized(() async {
      final results = await Future.wait([
        playerManagerNotifier.getGalleryById(id),
        playerManagerNotifier.getFileById(id),
      ]);
      return results[0];
    }, [id]);

    final getFileSnapshot = useFuture(getFile);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (playerManager.file != null) {
          print(playerManager.file);
          playerManagerNotifier.addController(
            VideoPlayerController.file(playerManager.file!),
          );
        }
      });
    }, [getFileSnapshot.hasData]);

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     playerManagerNotifier.addController(
    //       VideoPlayerController.network(
    //         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       ),
    //     );
    //   });
    //   return null;
    // }, []);

    final initialize = useMemoized(() async {
      if (playerManager.controller == null) {
        return false;
      }
      await playerManagerNotifier.initializeController();
      await playerManagerNotifier.play();
      return true;
    }, [playerManager.controller]);

    final initializeSnapshot = useFuture(initialize, initialData: false);

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          if (getFileSnapshot.hasData && (initializeSnapshot.data ?? false))
            PlayerViewer(controller: playerManager.controller!),
          if (getFileSnapshot.hasData && (initializeSnapshot.data ?? false))
            const PlayerController(),
        ],
      ),
    );
  }
}
