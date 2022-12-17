import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/application/report/interactor_report.dart';
import 'package:memo_app/database/database.dart' as db;
import 'package:memo_app/domain/report/entity_report.dart';
import 'package:memo_app/interface/report/repository_report.dart';

part 'report_edit.freezed.dart';

@freezed
class ReportEditState with _$ReportEditState {
  const ReportEditState._();

  factory ReportEditState({
    Report? report,
    @Default(ReportTrick()) ReportTrick trick,
    @Default(ReportResult()) ReportResult result,
  }) = _ReportEditState;
}

class ReportEditModel extends StateNotifier<ReportEditState> {
  ReportEditModel() : super(ReportEditState());
  final reportInteractor =
      InteractorReport(RepositoryReport(db.AppDatabase(null)));

  setTrick(ReportTrick trick) {
    state = state.copyWith(trick: trick);
  }

  setResult(ReportResult result) {
    state = state.copyWith(result: result);
  }

  Future<void> getReport(String videoId) async {
    final report =
        await reportInteractor.getReport(videoId) ?? Report(videoId: videoId);
    print(report);
    state = state.copyWith(
      report: report,
      trick: report.trick,
      result: report.result,
    );
  }

  Future<void> saveReport() async {
    if (state.report == null) {
      return;
    }
    reportInteractor.saveReport(state.report!);
  }
}
