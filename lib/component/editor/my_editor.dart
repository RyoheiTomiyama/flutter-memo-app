import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/editor/initial_document.dart';
import 'package:memo_app/component/editor/toolbar.dart';
import 'package:memo_app/component/editor/toolbar_container.dart';
import 'package:memo_app/component/editor/toolbar_visible.dart';
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
    final editor =
        useState(DocumentEditor(document: doc.value as MutableDocument));
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
        // print(selection.value.isCollapsed);
        return !selection.value.isCollapsed;
      },
      [selection.value.isCollapsed],
    );

    final calcAnchor = useCallback(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      });
    }, [visibleToolbar, selection.value, doc.value]);

    useEffect(
      () {
        calcAnchor();
      },
      [visibleToolbar, selection.value, doc.value],
    );

    useEffect(() {
      editor.value.document.addListener(calcAnchor);
      return () {
        editor.value.document.removeListener(calcAnchor);
      };
    }, [editor.value.document]);

    final composer =
        useRef(DocumentComposer(initialSelection: selection.value));
    // useListenableSelector(composer.value, () => composer.value);

    watchSelection() {
      if (composer.value.selection == null ||
          (selection.value.base == composer.value.selection?.base &&
              selection.value.extent == composer.value.selection?.extent)) {
        return;
      }
      print('update selection: ${composer.value.selection?.base.nodePosition}');
      selection.value = composer.value.selection!;
    }

    composer.value.selectionNotifier.addListener(watchSelection);

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
          ToolbarVisible(
            document: doc.value,
            selection: selection.value,
            child: ToolbarContainer(
              selection: selection.value,
              docLayoutKey: _docLayoutKey,
              editorScrollController: scrollController,
              child: Toolbar(
                selection: selection.value,
                editor: editor.value,
                editorFocus: editorFocus,
                composer: composer.value,
              ),
            ),
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
