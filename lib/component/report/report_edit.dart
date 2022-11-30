import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/report/report_edit_result.dart';
import 'package:memo_app/component/report/report_edit_trick.dart';
import 'package:memo_app/provider/report_edit_provider.dart';

class ReportEdit extends HookConsumerWidget {
  const ReportEdit({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reportEdit = ref.watch(reportEditProvider);
    print(reportEdit.result);
    print(reportEdit.trick);

    return Expanded(
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.amber,
        child: Column(
          children: [
            ReportEditTrick(),
            ReportEditResult(),
          ],
        ),
      ),
    );
  }
}
