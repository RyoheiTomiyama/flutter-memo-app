// アプリケーションロジックdomain/../repository.dartの実装
import 'dart:io';
import 'dart:ui';

import 'dart:typed_data';

import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/repository_gallery.dart';
import 'package:photo_manager/photo_manager.dart';

class RepositoryGallery implements IRepositoryGallery {
  @override
  Future<List<Gallery>> getGalleries() async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      // Granted.
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        // type: RequestType.video,
        hasAll: true,
        onlyAll: false,
      );
      final allVideoPath = paths.firstWhere((element) => element.isAll);
      final count = await allVideoPath.assetCountAsync;
      final assetList =
          await allVideoPath.getAssetListRange(start: 0, end: count);
      return assetList
          .map(
            (asset) => Gallery(
              id: asset.id,
              path: asset.title ?? '',
              createdAt: asset.createDateTime,
              modifiedAt: asset.modifiedDateTime,
            ),
          )
          .toList();
      // Granted.
      // final List<AssetEntity> entities = await path.getAssetListPaged(page: 0, size: 80,);
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
}
