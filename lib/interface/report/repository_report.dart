import 'package:drift/drift.dart';
import 'package:memo_app/database/database.dart' as db;
import 'package:memo_app/domain/report/entity_report.dart';
import 'package:memo_app/domain/report/repository_report.dart';

class RepositoryReport implements IRepositoryReport {
  final db.AppDatabase database;

  RepositoryReport(this.database);

  @override
  Future<Report?> getReport(String videoId) async {
    final dbReport = await (database.select(database.reports)
          ..where((r) => r.videoId.equals(videoId)))
        .getSingleOrNull();
    if (dbReport == null) {
      return null;
    }
    return Report(id: dbReport.id, videoId: dbReport.videoId);
  }

  @override
  Future<int> createReport(Report report) async {
    final id = await database
        .into(database.reports)
        .insert(db.ReportsCompanion(videoId: Value(report.videoId)));
    return id;
  }

  @override
  Future<int> updateReport(Report report) async {
    final id = report.id;
    if (id == null) {
      throw InvalidDataException('[updateReport] failed update. id is null');
    }
    final updatedId = await (database.update(database.reports)
          ..where((r) => r.id.equals(id)))
        .write(db.ReportsCompanion(videoId: Value(report.videoId)));
    return updatedId;
  }
}
