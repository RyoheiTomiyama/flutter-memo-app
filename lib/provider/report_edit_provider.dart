import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/model/report_edit.dart';

final reportEditProvider =
    StateNotifierProvider<ReportEditModel, ReportEditState>(
  (ref) => ReportEditModel(),
);
