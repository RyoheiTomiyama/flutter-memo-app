class Report {
  final String id;
  final String path;
  final ReportResult? result;
  late DateTime createdAt;
  late DateTime modifiedAt;

  Report({
    required this.id,
    required this.path,
    this.result,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.modifiedAt = modifiedAt ?? now;
  }
}

class ReportResult {
  final String id;
  final int approachScore;
  final int takeoffScore;
  final int peakScore;
  final int landingScore;

  ReportResult({
    required this.id,
    required this.approachScore,
    required this.takeoffScore,
    required this.peakScore,
    required this.landingScore,
  });
}
