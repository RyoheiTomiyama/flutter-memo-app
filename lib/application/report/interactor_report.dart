// UseCase Interactor
// ユースケースを実現するのにどういう処理をするのか
import 'package:memo_app/domain/report/entity_report.dart';
import 'package:memo_app/domain/report/repository_report.dart';
import 'package:memo_app/domain/report/usecase_report.dart';

class InteractorReport implements IUsecaseReport {
  final IRepositoryReport reportRepository;

  InteractorReport(this.reportRepository);

  @override
  Future<Report?> getReport(String videoId) async {
    final report = await reportRepository.getReport(videoId);
    return report;
  }

  @override
  Future<Report?> saveReport(Report report) async {
    int id;
    if (report.id == null) {
      id = await reportRepository.createReport(report);
    } else {
      id = await reportRepository.updateReport(report);
    }
    return getReport(report.videoId);
  }
}
