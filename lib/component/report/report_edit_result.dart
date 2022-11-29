import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/ui/form/rating_bar.dart';
import 'package:memo_app/ui/report/report_edit_row.dart';

class ReportEditResult extends HookWidget {
  const ReportEditResult({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: RatingBar(value: 5),
          ),
          ReportEditRow(
            label: '抜け',
            child: RatingBar(value: 8),
          ),
          ReportEditRow(
            label: '空中',
            child: RatingBar(),
          ),
          ReportEditRow(
            label: 'ランディング',
            child: RatingBar(),
          ),
        ],
      ),
    );
  }
}
