import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/component/report/report_edit.dart';
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

class VideoPlayback extends HookWidget {
  final String id;
  const VideoPlayback({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
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
