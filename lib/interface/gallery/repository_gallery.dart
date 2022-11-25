// アプリケーションロジックdomain/../repository.dartの実装
import 'dart:io';
import 'dart:ui';

import 'dart:typed_data';

import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery_album.dart';
import 'package:memo_app/domain/gallery/repository_gallery.dart';
import 'package:photo_manager/photo_manager.dart';

class RepositoryGallery implements IRepositoryGallery {
  @override
  Future<List<GalleryAlbum>> getGalleryAlbums() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.video,
      hasAll: true,
      onlyAll: false,
    );
    final mapAlbum = await Future.wait(paths.map((path) async {
      if (await path.assetCountAsync > 0) {
        return _createGalleryAlbum(path);
      }
    }));
    return mapAlbum.whereType<GalleryAlbum>().toList();
  }

  @override
  Future<List<Gallery>> getGalleries(GalleryAlbum? album) async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      // Granted.
      AssetPathEntity path;
      if (album == null) {
        final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
          type: RequestType.video,
          hasAll: true,
          onlyAll: true,
        );
        path = paths.firstWhere((element) => element.isAll);
      } else {
        path = await AssetPathEntity.fromId(album.id, type: RequestType.video);
      }
      final count = await path.assetCountAsync;
      if (count == 0) {
        return [];
      }
      final assetList = await path.getAssetListRange(start: 0, end: count);
      return assetList.map((asset) => _createGallery(asset)).toList();
    } else {
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
      // PhotoManager.openSetting();
      throw Exception('not permitted');
    }
  }

  @override
  Future<Uint8List> getThumbnail(
    Gallery gallery, {
    Size size = const Size(200, 200),
  }) async {
    final asset = await AssetEntity.fromId(gallery.id);
    if (asset == null) {
      throw Exception('not found file');
    }
    ThumbnailOption option;
    if (Platform.isIOS || Platform.isMacOS) {
      option = ThumbnailOption.ios(
        size: ThumbnailSize(size.width.toInt(), size.height.toInt()),
        resizeContentMode: ResizeContentMode.fill,
      );
    } else {
      option = ThumbnailOption(
        size: ThumbnailSize(size.width.toInt(), size.height.toInt()),
      );
    }
    final thumbnail = await asset.thumbnailDataWithOption(option);
    if (thumbnail == null) {
      throw Exception('failed create thumbnail');
    }
    return thumbnail;
  }

  @override
  Future<Gallery> getGallery({required String id}) async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      final AssetEntity? asset = await AssetEntity.fromId(id);
      if (asset == null) {
        throw Exception('not found file');
      }
      return _createGallery(asset);
    } else {
      throw Exception('not permitted');
    }
  }

  @override
  Future<File> getGalleryFile(Gallery gallery) async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      final AssetEntity? asset = await AssetEntity.fromId(gallery.id);
      if (asset == null) {
        throw Exception('not found AssetEntity');
      }
      final file = await asset.file;
      if (file == null) {
        throw Exception('not found file');
      }
      return file;
    } else {
      throw Exception('not permitted');
    }
  }
}

Gallery _createGallery(AssetEntity asset) {
  return Gallery(
    id: asset.id,
    path: asset.title ?? '',
    createdAt: asset.createDateTime,
    modifiedAt: asset.modifiedDateTime,
  );
}

GalleryAlbum _createGalleryAlbum(AssetPathEntity asset) {
  return GalleryAlbum(
    id: asset.id,
    name: asset.name,
    isAll: asset.isAll,
  );
}
