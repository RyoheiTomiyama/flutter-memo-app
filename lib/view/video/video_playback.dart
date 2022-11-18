import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';

class VideoPlayback extends HookWidget {
  const VideoPlayback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SwipeUpPanel(
        body: Player(),
      ),
    );
  }
}
