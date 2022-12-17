import 'package:memo_app/domain/report/entity_report.dart';

abstract class IRepositoryReport {
  Future<Report?> getReport(String id);

  Future<int> createReport(Report report);

  Future<int> updateReport(Report report);
}
