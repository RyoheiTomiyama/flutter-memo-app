// DBなどの外部サービスとどういう処理を行いたいのか
import 'package:memo_app/domain/gallery/entity_gallery.dart';

abstract class IRepositoryGallery {
  Future<List<Gallery>> getGalleries();
}
