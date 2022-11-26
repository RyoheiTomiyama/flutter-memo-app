import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';
import 'package:memo_app/view/view_base.dart';

class VideoPlaybackArgument extends Object {
  final String id;

  const VideoPlaybackArgument({required this.id});
}

class VideoPlaybackView implements ViewBase {
  @override
  get builder => (context, {args}) {
        if (args is! VideoPlaybackArgument) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          return Container();
        } else {
          return VideoPlayback(id: args.id);
        }
      };

  @override
  String get name => '/player';
}

class VideoPlayback extends HookWidget {
  final String id;
  const VideoPlayback({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SwipeUpPanel(
        body: Player(id: id),
      ),
    );
  }
}
