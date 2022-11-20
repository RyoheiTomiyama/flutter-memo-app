import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/video_gallery/video_gallery_list.dart';
import 'package:memo_app/provider/video_gallery_provider.dart';

class VideoList extends HookConsumerWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final videoGalleryNotifier = ref.watch(videoGalleryProvider.notifier);
    final videoGallery = ref.watch(videoGalleryProvider);

    final getGallery = useMemoized(() async {
      await videoGalleryNotifier.getGallery();
      return true;
    }, []);

    final getGallerySnapshot = useFuture(getGallery);

    if (getGallerySnapshot.hasData) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: VideoGalleryList(items: videoGallery.galleryList),
      );
    }
    return const SizedBox();
  }
}
