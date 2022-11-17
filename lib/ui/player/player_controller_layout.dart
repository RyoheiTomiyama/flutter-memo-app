import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayerControllerLayout extends HookWidget {
  final Widget? buildHeader;
  final Widget? buildBody;
  final Widget? buildFooter;
  const PlayerControllerLayout({
    super.key,
    this.buildHeader,
    this.buildBody,
    this.buildFooter,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (buildHeader != null) buildHeader!,
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (buildBody != null) buildBody!,
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (buildFooter != null) buildFooter!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
