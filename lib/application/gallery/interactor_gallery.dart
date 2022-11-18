// UseCase Interactor
// ユースケースを実現するのにどういう処理をするのか
import 'package:memo_app/domain/gallery/entity_gallery.dart';
import 'package:memo_app/domain/gallery/repository_gallery.dart';
import 'package:memo_app/domain/gallery/usecase_gallery.dart';

class InteractorGallery implements IUsecaseGallery {
  final IRepositoryGallery galleryRepository;

  InteractorGallery(this.galleryRepository);

  @override
  Future<List<Gallery>> getGalleries() async {
    final list = await galleryRepository.getGalleries();
    return list;
  }
}
