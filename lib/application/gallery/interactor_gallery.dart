// UseCase Interactor
// ユースケースを実現するのにどういう処理をするのか
import 'dart:io';
import 'dart:ui';

import 'dart:typed_data';

import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery_album.dart';
import 'package:memo_app/domain/gallery/repository_gallery.dart';
import 'package:memo_app/domain/gallery/usecase_gallery.dart';

class InteractorGallery implements IUsecaseGallery {
  final IRepositoryGallery galleryRepository;

  InteractorGallery(this.galleryRepository);

  @override
  Future<List<GalleryAlbum>> getGalleryAlbums() async {
    final list = await galleryRepository.getGalleryAlbums();
    return list;
  }

  @override
  Future<List<Gallery>> getGalleries([GalleryAlbum? album]) async {
    final list = await galleryRepository.getGalleries(album);
    return list;
  }

  @override
  Future<Uint8List> getThumbnail(
    Gallery gallery, {
    Size size = const Size(200, 200),
  }) {
    return galleryRepository.getThumbnail(gallery, size: size);
  }

  @override
  Future<File> getFileById(String id) async {
    final Gallery gallery = await galleryRepository.getGallery(id: id);
    return galleryRepository.getGalleryFile(gallery);
  }
}
