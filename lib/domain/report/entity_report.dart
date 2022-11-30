import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memo_app/domain/report/enum_report.dart';

part 'entity_report.freezed.dart';

class Report {
  final String? id;
  final String path;
  final ReportTrick? trick;
  final ReportResult? result;
  late DateTime createdAt;
  late DateTime modifiedAt;

  Report({
    this.id,
    required this.path,
    this.trick,
    this.result,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.modifiedAt = modifiedAt ?? now;
  }
}

@freezed
class ReportTrick with _$ReportTrick {
  const factory ReportTrick({
    @Default(null) String? id,
    @Default(null) ReportStance? stance,
    @Default(null) ReportDirection? direction,
    @Default(null) ReportSpin? spin,
  }) = $ReportTrick;
}

@freezed
class ReportResult with _$ReportResult {
  const factory ReportResult({
    @Default(null) String? id,
    @Default(null) int? approachScore,
    @Default(null) int? takeoffScore,
    @Default(null) int? peakScore,
    @Default(null) int? landingScore,
  }) = $ReportResult;
}
