import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/provider/report_edit_provider.dart';
import 'package:memo_app/ui/form/rating_bar.dart';
import 'package:memo_app/ui/report/report_edit_row.dart';

class ReportEditResult extends HookConsumerWidget {
  const ReportEditResult({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reportEdit = ref.watch(reportEditProvider);
    final reportEditNotifier = ref.watch(reportEditProvider.notifier);

    if (reportEdit.result == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 0),
            child: Text(
              '評価',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ReportEditRow(
            label: 'アプローチ',
            child: RatingBar(
              value: reportEdit.result!.approachScore,
              onChange: (newValue) => reportEditNotifier.setResult(
                reportEdit.result!.copyWith(approachScore: newValue),
              ),
            ),
          ),
          ReportEditRow(
            label: '抜け',
            child: RatingBar(
              value: reportEdit.result!.takeoffScore,
              onChange: (newValue) => reportEditNotifier.setResult(
                reportEdit.result!.copyWith(takeoffScore: newValue),
              ),
            ),
          ),
          ReportEditRow(
            label: '空中',
            child: RatingBar(
              value: reportEdit.result!.peakScore,
              onChange: (newValue) => reportEditNotifier.setResult(
                reportEdit.result!.copyWith(peakScore: newValue),
              ),
            ),
          ),
          ReportEditRow(
            label: 'ランディング',
            child: RatingBar(
              value: reportEdit.result!.landingScore,
              onChange: (newValue) => reportEditNotifier.setResult(
                reportEdit.result!.copyWith(landingScore: newValue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
