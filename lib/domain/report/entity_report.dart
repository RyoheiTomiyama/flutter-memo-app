import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo_app/domain/report/enum_report.dart';

part 'entity_report.freezed.dart';

class Report {
  final int? id;
  final String videoId;
  late ReportTrick trick;
  late ReportResult result;
  late DateTime createdAt;
  late DateTime modifiedAt;

  Report({
    this.id,
    required this.videoId,
    ReportTrick? trick,
    ReportResult? result,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.modifiedAt = modifiedAt ?? now;
    this.trick = trick ?? const ReportTrick();
    this.result = result ?? const ReportResult();
  }
}

@freezed
class ReportTrick with _$ReportTrick {
  const factory ReportTrick({
    @Default(null) int? id,
    @Default(null) ReportStance? stance,
    @Default(null) ReportDirection? direction,
    @Default(null) ReportSpin? spin,
  }) = $ReportTrick;
}

@freezed
class ReportResult with _$ReportResult {
  const factory ReportResult({
    @Default(null) int? id,
    @Default(null) int? approachScore,
    @Default(null) int? takeoffScore,
    @Default(null) int? peakScore,
    @Default(null) int? landingScore,
  }) = $ReportResult;
}
