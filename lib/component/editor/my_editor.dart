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
    initLoggers(Level.ALL, {editorStyleLog});
    final editorFocus = useFocusNode(debugLabel: 'editorFocus');
    final doc = useRef(createInitialDocument());
    final editor =
        useState(DocumentEditor(document: doc.value as MutableDocument));
    final composer = useRef(DocumentComposer());
    useListenableSelector(composer.value, () => composer.value);
    composer.value.selectionNotifier.addListener(
      () => log('hoge ${composer.value.selection}'),
    );
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
        ),
        MyToolbar(editorFocus: editorFocus),
      ],
    );
  }
}
