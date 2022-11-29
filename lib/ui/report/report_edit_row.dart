import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReportEditRow extends HookWidget {
  final String label;
  final Widget child;
  const ReportEditRow({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 88,
            child: Text(label),
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.onBackground,
            width: 32,
            thickness: 1,
          ),
          child,
        ],
      ),
    );
  }
}
