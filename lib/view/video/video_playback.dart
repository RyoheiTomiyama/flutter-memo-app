import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/component/report/report_edit.dart';
import 'package:memo_app/provider/report_edit_provider.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';
import 'package:memo_app/view/view_base.dart';

class VideoPlaybackArgument extends Object {
  final String id;

  const VideoPlaybackArgument({required this.id});
  Map<String, String> toMap() {
    return {
      'id': id,
    };
  }
}

class VideoPlaybackView implements ViewBase {
  @override
  get builder => (context, state) {
        final id = state.params['id'];
        if (id == null) {
          return Container();
        } else {
          return VideoPlayback(id: id);
        }
      };

  @override
  String get path => '/video/:id';
}

class VideoPlayback extends HookConsumerWidget {
  final String id;
  const VideoPlayback({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    final reportEditNotifier = ref.watch(reportEditProvider.notifier);

    final intervalSaveReport = useCallback((Timer _) {
      reportEditNotifier.saveReport();
    }, [reportEditNotifier]);

    // 定期的に保存
    final appState = useAppLifecycleState();
    useEffect(() {
      // アクティブ時のみタイマー実行
      if (appState == AppLifecycleState.resumed) {
        final t = Timer.periodic(
          const Duration(seconds: 3),
          intervalSaveReport,
        );
        return () {
          t.cancel();
        };
      }
    }, [intervalSaveReport, appState]);

    // 画面離脱時に保存
    useEffect(() {
      return () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await reportEditNotifier.saveReport();
          reportEditNotifier.reset();
        });
      };
    }, []);
    // アプリ離脱時に保存
    useOnAppLifecycleStateChange(((previous, current) {
      if (current != AppLifecycleState.resumed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await reportEditNotifier.saveReport();
        });
      }
    }));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SwipeUpPanel(
        maxChildSize: 0.8,
        body: Player(id: id),
        child: ReportEdit(videoId: id),
      ),
    );
  }
}
