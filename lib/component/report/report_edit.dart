import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/report/report_edit_result.dart';
import 'package:memo_app/component/report/report_edit_trick.dart';

class ReportEdit extends HookWidget {
  const ReportEdit({super.key});

  @override
  Widget build(BuildContext context) {
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
