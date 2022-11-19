import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/model/video_gallery.dart';

final videoGalleryProvider =
    StateNotifierProvider<VideoGalleryModel, VideoGalleryState>(
  (ref) => VideoGalleryModel(),
);
