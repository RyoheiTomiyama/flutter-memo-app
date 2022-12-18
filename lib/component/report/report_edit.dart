import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:memo_app/component/report/report_edit_result.dart';
import 'package:memo_app/component/report/report_edit_trick.dart';
import 'package:memo_app/provider/player_manager_provider.dart';
import 'package:memo_app/provider/report_edit_provider.dart';
import 'package:path/path.dart';

class ReportEdit extends HookConsumerWidget {
  final String videoId;
  const ReportEdit({
    super.key,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final playerManager = ref.watch(playerManagerProvider);
    final reportEditManagerNotifier = ref.watch(reportEditProvider.notifier);
    // print(reportEdit.result);
    // print(reportEdit.trick);

    final getReport = useMemoized(() async {
      final results = await Future.wait([
        reportEditManagerNotifier.getReport(videoId),
      ]);
      return results[0];
    }, [videoId]);
    useFuture(getReport);

    final intervalSaveReport = useCallback((Timer _timer) {
      reportEditManagerNotifier.saveReport();
      print('save report');
    }, [reportEditManagerNotifier]);

    // 定期的に保存
    useEffect(() {
      final t = Timer.periodic(const Duration(seconds: 3), intervalSaveReport);
      return () {
        t.cancel();
      };
    }, [intervalSaveReport]);

    final formatDate = useMemoized(() {
      if (playerManager.gallery?.modifiedAt != null) {
        final format = DateFormat.yMMMd().add_Hms();
        return format.format(playerManager.gallery!.modifiedAt);
      }
      return '';
    }, [playerManager.gallery?.modifiedAt]);

    useEffect(() {
      return () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          reportEditManagerNotifier.reset();
        });
      };
    }, []);

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.video_camera_back_outlined,
                      size: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      basename(playerManager.file?.path.toString() ?? ''),
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      size: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      formatDate,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ReportEditTrick(),
          ReportEditResult(),
        ],
      ),
    );
  }
}
