// アプリがどういう動作を求めているか
import 'package:memo_app/domain/gallery/entity_gallery.dart';

abstract class IUsecaseGallery {
  // ギャラリー一覧を取得する
  Future<List<Gallery>> getGalleries();
}
