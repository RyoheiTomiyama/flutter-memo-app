import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Panel extends HookWidget {
  final double maxHeight;
  final Widget? child;
  final ScrollController? controller;
  final bool isFullOpened;

  const Panel({
    Key? key,
    required this.maxHeight,
    this.child,
    this.controller,
    this.isFullOpened = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: maxHeight,
      child: Container(
        // width: 300,
        height: maxHeight,
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 30,
                height: 3,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                // SwipeUpPanelでスクロールをコントロールする
                physics: const NeverScrollableScrollPhysics(),
                child: child ?? Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
