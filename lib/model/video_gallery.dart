import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/application/gallery/interactor_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery_album.dart';
import 'package:memo_app/interface/gallery/repository_gallery.dart';

part 'video_gallery.freezed.dart';

@freezed
class VideoGalleryState with _$VideoGalleryState {
  const VideoGalleryState._();

  const factory VideoGalleryState({
    @Default([]) List<Gallery> galleryList,
    @Default([]) List<GalleryAlbum> albumList,
    @Default(null) String? currentAlbumId,
  }) = _VideoGalleryState;
}

class VideoGalleryModel extends StateNotifier<VideoGalleryState> {
  VideoGalleryModel() : super(const VideoGalleryState());

  final galleryInteractor = InteractorGallery(RepositoryGallery());

  Future<void> getAlbum() async {
    final albums = await galleryInteractor.getGalleryAlbums();
    final currentAlbumId = state.currentAlbumId ??
        albums.firstWhereOrNull((element) => element.isAll)?.id;
    state = state.copyWith(
      albumList: albums,
      currentAlbumId: currentAlbumId,
    );
  }

  Future<void> getGallery() async {
    final currentAlbum =
        state.albumList.firstWhereOrNull((el) => el.id == state.currentAlbumId);
    final galleries = await galleryInteractor.getGalleries(currentAlbum);
    state = state.copyWith(galleryList: galleries);
  }

  Future<Uint8List> getThumbnail(Gallery gallery) async {
    final thumbnail = await galleryInteractor.getThumbnail(gallery);
    return thumbnail;
  }

  void changeAlbum(String albumId) {
    state = state.copyWith(currentAlbumId: albumId);
  }
}
