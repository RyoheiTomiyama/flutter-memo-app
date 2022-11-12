import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:memo_app/component/editor/initial_document.dart';
import 'package:memo_app/component/editor/my_toolbar.dart';
import 'package:super_editor/super_editor.dart';

class MyEditor extends HookWidget {
  const MyEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey _docLayoutKey = useMemoized(() => GlobalKey());

    // initLoggers(Level.ALL, {editorStyleLog});
    final editorFocus = useFocusNode(debugLabel: 'editorFocus');
    final doc = useRef(createInitialDocument());
    final selection = useState(DocumentSelection.collapsed(
      position: DocumentPosition(
        nodeId: doc.value.nodes.last.id, // Place caret at end of document
        nodePosition: (doc.value.nodes.last as TextNode).endPosition,
      ),
    ));
    final visibleToolbar = useMemoized(() {
      print(selection.value.isCollapsed);
      return !selection.value.isCollapsed;
    }, [selection.value.isCollapsed]);
    final anchor = useMemoized(() {
      if (_docLayoutKey.currentState == null) {
        return null;
      }
      final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
          .getRectForSelection(selection.value!.base, selection.value!.extent)!;
      final docBox =
          _docLayoutKey.currentContext!.findRenderObject() as RenderBox;
      final overlayBoundingBox = Rect.fromPoints(
        docBox.localToGlobal(docBoundingBox.topLeft),
        docBox.localToGlobal(docBoundingBox.bottomRight),
      );
      print('change anchor ${overlayBoundingBox.topCenter}');
      return overlayBoundingBox.topCenter;
    }, [visibleToolbar, selection.value]);

    final editor =
        useState(DocumentEditor(document: doc.value as MutableDocument));
    final composer =
        useRef(DocumentComposer(initialSelection: selection.value));
    useListenableSelector(composer.value, () => composer.value);

    watchSelection() {
      if (composer.value.selection == null ||
          (selection.value.base == composer.value.selection?.base &&
              selection.value.extent == composer.value.selection?.extent)) {
        return;
      }
      print('update selection: ${composer.value.selection.toString()}');
      selection.value = composer.value.selection!;
    }

    composer.value.selectionNotifier.addListener(watchSelection);
    editorFocus.addListener(
        () => print('f: ${editorFocus.hasFocus} ${composer.value.selection}'));
    return Stack(
      children: [
        SuperEditor(
          editor: editor.value,
          composer: composer.value,
          debugPaint: DebugPaintConfig(gestures: true),
          focusNode: editorFocus,
          autofocus: true,
          documentLayoutKey: _docLayoutKey,
        ),
        if (!selection.value.isCollapsed)
          SafeArea(
            child: MyToolbar(
              anchor: anchor,
              editorFocus: editorFocus,
            ),
          ),
      ],
    );
  }
}
