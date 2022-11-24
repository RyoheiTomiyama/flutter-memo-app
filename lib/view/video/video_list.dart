import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/video_gallery/video_gallery_list.dart';
import 'package:memo_app/provider/video_gallery_provider.dart';
import 'package:memo_app/view/view_base.dart';

class VideoListView implements ViewBase {
  @override
  ViewBuilder get builder => (context, {args}) => const VideoList();

  @override
  String get name => '/video-gallery';
}

class VideoList extends HookConsumerWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    print('render');
    final videoGalleryNotifier = ref.watch(videoGalleryProvider.notifier);
    final videoGallery = ref.watch(videoGalleryProvider);

    final getGallery = useMemoized(() async {
      await videoGalleryNotifier.getGallery();
      // TODO ０件のアルバムだと値が返ってこないend > startの条件に一致しないため
      print('hoge');
      return true;
    }, [videoGallery.currentAlbum]);

    final getAlbum = useMemoized(() async {
      await videoGalleryNotifier.getAlbum();
      return true;
    }, []);

    final getGallerySnapshot = useFuture(getGallery);
    final getAlbumSnapshot = useFuture(getAlbum);

    print(getGallerySnapshot.hasData);
    print(getAlbumSnapshot.hasData);

    if (getGallerySnapshot.hasData && getAlbumSnapshot.hasData) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: VideoGalleryList(items: videoGallery.galleryList),
      );
    }
    return const SizedBox();
  }
}
