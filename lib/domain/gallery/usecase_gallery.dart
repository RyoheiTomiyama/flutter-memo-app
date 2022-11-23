// アプリがどういう動作を求めているか
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/entity_gallery_album.dart';

abstract class IUsecaseGallery {
  // アルバム一覧を取得する
  Future<List<GalleryAlbum>> getGalleryAlbums();

  // ギャラリー一覧を取得する
  Future<List<Gallery>> getGalleries([GalleryAlbum? album]);

  // サムネイルを取得する
  Future<Uint8List> getThumbnail(Gallery gallery, {Size size});

  // idから動画Fileを取得する
  Future<File> getFileById(String id);
}
