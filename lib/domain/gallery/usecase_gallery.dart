// アプリがどういう動作を求めているか
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';

abstract class IUsecaseGallery {
  // ギャラリー一覧を取得する
  Future<List<Gallery>> getGalleries();

  // サムネイルを取得する
  Future<Uint8List> getThumbnail(Gallery gallery, {Size size});
}
