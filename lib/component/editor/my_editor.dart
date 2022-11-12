import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:memo_app/component/editor/initial_document.dart';
import 'package:memo_app/component/editor/my_toolbar.dart';
import 'package:memo_app/component/editor/toolbar_container.dart';
import 'package:super_editor/super_editor.dart';

class MyEditor extends HookWidget {
  const MyEditor({super.key});

  // updateAnchorPoint()

  @override
  Widget build(BuildContext context) {
    final GlobalKey _docLayoutKey = useMemoized(() => GlobalKey());

    // initLoggers(Level.ALL, {editorStyleLog});
    final editorFocus = useFocusNode(debugLabel: 'editorFocus');
    final doc = useRef(createInitialDocument());
    final scrollController = useScrollController();
    final selection = useState(DocumentSelection.collapsed(
      position: DocumentPosition(
        nodeId: doc.value.nodes.first.id, // Place caret at end of document
        nodePosition: doc.value.nodes.first.beginningPosition,
      ),
    ));
    final anchor = useState<Offset?>(null);

    final visibleToolbar = useMemoized(
      () {
        print(selection.value.isCollapsed);
        return !selection.value.isCollapsed;
      },
      [selection.value.isCollapsed],
    );

    useEffect(
      () {
        if (_docLayoutKey.currentState == null || selection.value.isCollapsed) {
          anchor.value = Offset.zero;
          return;
        }
        final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
            .getRectForSelection(selection.value.base, selection.value.extent)!;
        final docBox =
            _docLayoutKey.currentContext!.findRenderObject() as RenderBox;
        final overlayBoundingBox = Rect.fromPoints(
          docBox.localToGlobal(docBoundingBox.topLeft),
          docBox.localToGlobal(docBoundingBox.bottomRight),
        );
        // print('change anchor ${overlayBoundingBox.topCenter}');
        anchor.value = overlayBoundingBox.topCenter;
      },
      [visibleToolbar, selection.value],
    );

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
    scrollController.addListener(() => print('scroll'));
    editorFocus.addListener(
        () => print('f: ${editorFocus.hasFocus} ${composer.value.selection}'));
    return Stack(
      children: [
        SuperEditor(
          editor: editor.value,
          composer: composer.value,
          debugPaint: DebugPaintConfig(gestures: true),
          focusNode: editorFocus,
          // autofocus: true,
          documentLayoutKey: _docLayoutKey,
          scrollController: scrollController,
        ),
        if (!selection.value.isCollapsed &&
            _docLayoutKey.currentContext != null)
          ToolbarContainer(
            selection: selection.value,
            docLayoutKey: _docLayoutKey,
            editorScrollController: scrollController,
          ),
        // SafeArea(
        //   child: MyToolbar(
        //     anchor: anchor.value,
        //     editorFocus: editorFocus,
        //   ),
        // ),
      ],
    );
  }
}
