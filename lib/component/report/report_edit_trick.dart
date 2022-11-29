import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/ui/form/scroll_picker.dart';
import 'package:memo_app/ui/form/switch_button.dart';
import 'package:memo_app/ui/report/report_edit_row.dart';

class ReportEditTrick extends HookWidget {
  const ReportEditTrick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'トリック',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ReportEditRow(
            label: 'スタンス',
            child: SwitchButton(),
          ),
          ReportEditRow(
            label: '回転数',
            child: ScrollPicker(),
          ),
        ],
      ),
    );
  }
}
