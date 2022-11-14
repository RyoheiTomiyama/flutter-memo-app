// Toolbar表示条件
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:super_editor/super_editor.dart';

class ToolbarVisible extends HookWidget {
  const ToolbarVisible({
    super.key,
    required this.child,
    required this.selection,
    required this.document,
    this.isMobile = false,
  });

  final Widget child;
  final DocumentSelection selection;
  final Document document;
  final bool isMobile;

  bool get isSingleSelection {
    return selection.base.nodeId == selection.extent.nodeId;
  }

  bool get isVisible {
    return isSingleSelection || isMobile;
  }

  DocumentNode? get selectedNode {
    if (!isSingleSelection) {
      return null;
    }
    return document.getNodeById(selection.extent.nodeId);
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return Container();
    }
    return child;
  }
}
