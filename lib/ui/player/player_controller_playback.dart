import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayerControllerPlayback extends HookWidget {
  final bool isPlay;
  final void Function()? onPressed;
  const PlayerControllerPlayback({
    super.key,
    this.isPlay = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white.withOpacity(0.8),
      iconSize: 60,
      icon: Icon(isPlay ? Icons.pause_rounded : Icons.play_arrow_rounded),
      onPressed: onPressed,
    );
  }
}
