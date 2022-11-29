import 'package:memo_app/domain/report/entity_report.dart';

abstract class IRepositoryReport {
  Future<Report> getReport(String id);

  Future<Report> saveReport(Report report);
}
