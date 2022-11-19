import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/provider/video_gallery_provider.dart';

class VideoGalleryImage extends HookConsumerWidget {
  final Gallery gallery;
  const VideoGalleryImage({super.key, required this.gallery});

  @override
  Widget build(BuildContext context, ref) {
    final videoGalleryNotifier = ref.watch(videoGalleryProvider.notifier);

    final getThumbnail = useMemoized(() {
      return videoGalleryNotifier.getThumbnail(gallery);
    }, [gallery]);

    final snapshot = useFuture(getThumbnail);

    if (snapshot.hasData && snapshot.data != null) {
      return SizedBox(
        width: 200,
        height: 200,
        child: Image.memory(
          snapshot.data!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          // color: Colors.amber,
        ),
      );
    }

    return Container();
  }
}
