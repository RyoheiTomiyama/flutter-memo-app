// DBなどの外部サービスとどういう処理を行いたいのか
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/domain/gallery/entity_gallery.dart';

abstract class IRepositoryGallery {
  Future<List<Gallery>> getGalleries();

  Future<Uint8List> getThumbnail(Gallery gallery, {Size size});
}
