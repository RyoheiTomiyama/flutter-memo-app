import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/domain/report/entity_report.dart';

part 'report_edit.freezed.dart';

@freezed
class ReportEditState with _$ReportEditState {
  const ReportEditState._();

  factory ReportEditState({
    @Default(ReportTrick()) ReportTrick trick,
    @Default(ReportResult()) ReportResult result,
  }) = _ReportEditState;
}

class ReportEditModel extends StateNotifier<ReportEditState> {
  ReportEditModel() : super(ReportEditState());

  setTrick(ReportTrick trick) {
    state = state.copyWith(trick: trick);
  }

  setResult(ReportResult result) {
    state = state.copyWith(result: result);
  }
}
