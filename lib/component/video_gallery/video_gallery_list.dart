import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:memo_app/component/video_gallery/video_gallery_image.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/provider/video_gallery_provider.dart';
import 'package:memo_app/ui/gallery/gallery_grid_view.dart';
import 'package:memo_app/ui/gallery/gallery_scroll_info.dart';
import 'package:memo_app/ui/gallery/gallery_scrollbar.dart';

const axisCount = 2;

class VideoGalleryList extends HookConsumerWidget {
  final List<Gallery> items;

  const VideoGalleryList({super.key, required this.items});

  @override
  Widget build(BuildContext context, ref) {
    final videoGallery = ref.watch(videoGalleryProvider);

    final currentNum = useState(0);
    final scrollController = useScrollController();
    // useListenable(scrollController);
    print('render');

    final onScroll = useCallback(() {
      // print('hoge ${scrollController.position.viewportDimension}');
      final columns = (items.length / axisCount).ceil();
      final innerHeight =
          scrollController.position.context.storageContext.size!.height +
              scrollController.position.maxScrollExtent;
      final columnHeight = innerHeight / columns;
      final n = (scrollController.position.pixels / columnHeight).floor();
      currentNum.value = n < 0 ? 0 : n;
      // print('$columns $columnHeight ${currentNum.value}');
    }, []);

    final infoValue = useMemoized(() {
      final gallery = videoGallery.galleryList[currentNum.value * axisCount];
      final format = DateFormat.yMd();
      return format.format(gallery.createdAt);
    }, [videoGallery.galleryList, currentNum.value]);

    useEffect(() {
      // print(scrollController.hasClients);
      scrollController.addListener(onScroll);
      return () {
        scrollController.removeListener(onScroll);
      };
    }, [onScroll]);

    return SafeArea(
      child: Stack(
        children: [
          GalleryScrollbar(
            // key: galleryKey,
            controller: scrollController,
            child: GalleryGridView(
              scrollController: scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return VideoGalleryImage(
                  gallery: items[index],
                );
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GalleryScrollInfo(value: infoValue),
          ),
        ],
      ),
    );
  }
}
