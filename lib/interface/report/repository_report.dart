import 'package:drift/drift.dart';
import 'package:memo_app/database/database.dart' as db;
import 'package:memo_app/domain/report/entity_report.dart';
import 'package:memo_app/domain/report/repository_report.dart';

class RepositoryReport implements IRepositoryReport {
  final db.AppDatabase database;

  RepositoryReport(this.database);

  @override
  Future<Report?> getReport(String videoId) async {
    final query = await (database.select(database.reports)
          ..where((r) => r.videoId.equals(videoId)))
        .join([
      innerJoin(
        database.reportTricks,
        database.reportTricks.reportId.equalsExp(database.reports.id),
      ),
      innerJoin(
        database.reportResults,
        database.reportResults.reportId.equalsExp(database.reports.id),
      ),
    ]).getSingleOrNull();
    final dbReport = query?.readTableOrNull(database.reports);
    final dbReportTrick = query?.readTableOrNull(database.reportTricks);
    final dbReportResult = query?.readTableOrNull(database.reportResults);

    if (dbReport == null) {
      return null;
    }
    final reportTrick = ReportTrick(
      id: dbReportTrick?.id,
      spin: dbReportTrick?.spin,
      stance: dbReportTrick?.stance,
      direction: dbReportTrick?.direction,
    );
    final reportResult = ReportResult(
      id: dbReportResult?.id,
      approachScore: dbReportResult?.approachScore,
      takeoffScore: dbReportResult?.takeoffScore,
      peakScore: dbReportResult?.peakScore,
      landingScore: dbReportResult?.landingScore,
    );
    return Report(
      id: dbReport.id,
      videoId: dbReport.videoId,
      trick: reportTrick,
      result: reportResult,
    );
  }

  @override
  Future<int> createReport(Report report) async {
    final id = await database.into(database.reports).insert(
          _createReportsCompanion(report),
        );
    await Future.wait([
      database
          .into(database.reportTricks)
          .insert(_createReportTricksCompanion(id, report.trick)),
      database
          .into(database.reportResults)
          .insert(_createReportResultsCompanion(id, report.result)),
    ]);
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
        .write(_createReportsCompanion(report));

    await Future.wait([
      (database.update(database.reportTricks)
            ..where((r) => r.reportId.equals(id)))
          .write(_createReportTricksCompanion(id, report.trick)),
      (database.update(database.reportResults)
            ..where((r) => r.reportId.equals(id)))
          .write(_createReportResultsCompanion(id, report.result)),
    ]);
    return updatedId;
  }
}

db.ReportsCompanion _createReportsCompanion(Report report) {
  return db.ReportsCompanion(videoId: Value(report.videoId));
}

db.ReportTricksCompanion _createReportTricksCompanion(
  int id,
  ReportTrick trick,
) {
  return db.ReportTricksCompanion(
    reportId: Value(id),
    direction: Value(trick.direction),
    stance: Value(trick.stance),
    spin: Value(trick.spin),
  );
}

db.ReportResultsCompanion _createReportResultsCompanion(
  int id,
  ReportResult result,
) {
  return db.ReportResultsCompanion(
    reportId: Value(id),
    approachScore: Value(result.approachScore),
    takeoffScore: Value(result.takeoffScore),
    peakScore: Value(result.peakScore),
    landingScore: Value(result.landingScore),
  );
}
