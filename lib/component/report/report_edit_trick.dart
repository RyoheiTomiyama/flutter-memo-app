import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/domain/report/enum_report.dart';
import 'package:memo_app/provider/report_edit_provider.dart';
import 'package:memo_app/ui/form/scroll_picker.dart';
import 'package:memo_app/ui/form/switch_button.dart';
import 'package:memo_app/ui/report/report_edit_row.dart';

class ReportEditTrick extends HookConsumerWidget {
  const ReportEditTrick({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reportEdit = ref.watch(reportEditProvider);
    final reportEditNotifier = ref.watch(reportEditProvider.notifier);
    // print(reportEdit.result);
    // print(reportEdit.trick);

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
            child: SwitchButton(
              value: reportEdit.trick.stance,
              onChange: (stance) {
                print(stance);
                reportEditNotifier.setTrick(
                  reportEdit.trick.copyWith(stance: stance),
                );
              },
              list: const [
                SwitchButtonItem(
                  label: 'メイン',
                  value: ReportStance.mainStance,
                ),
                SwitchButtonItem(
                  label: 'スイッチ',
                  value: ReportStance.switchStance,
                ),
              ],
            ),
          ),
          ReportEditRow(
            label: '回転方向',
            child: ScrollPicker(
              value: reportEdit.trick.direction,
              onChange: (direction) {
                reportEditNotifier.setTrick(
                  reportEdit.trick.copyWith(direction: direction),
                );
              },
              itemExtent: 120,
              list: ReportDirection.values
                  .map(
                    (direction) => ScrollPickerItem(
                      label: direction.name,
                      value: direction,
                    ),
                  )
                  .toList(),
            ),
          ),
          ReportEditRow(
            label: '回転数',
            child: ScrollPicker(
              value: reportEdit.trick.spin,
              onChange: (spin) {
                reportEditNotifier.setTrick(
                  reportEdit.trick.copyWith(spin: spin),
                );
              },
              itemExtent: 80,
              list: ReportSpin.values
                  .map(
                    (spin) => ScrollPickerItem(
                      label: spin.name,
                      value: spin,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
