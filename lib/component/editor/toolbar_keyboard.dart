import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ToolbarKeyboard extends HookWidget {
  const ToolbarKeyboard({
    super.key,
    required this.isMobile,
    required this.onCloseKeyboard,
    required this.child,
  });

  final bool isMobile;
  final void Function() onCloseKeyboard;
  final Widget child;

  Widget buildVerticalDivider() {
    return Container(
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return child;
    return Material(
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(child: child),
            buildVerticalDivider(),
            Center(
              child: IconButton(
                onPressed: onCloseKeyboard,
                icon: const Icon(Icons.keyboard_hide),
                splashRadius: 16,
                tooltip: 'close',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
