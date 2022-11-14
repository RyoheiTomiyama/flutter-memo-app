import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/editor/toolbar_keyboard.dart';
import 'package:super_editor/super_editor.dart';

class ToolbarContainer extends HookWidget {
  const ToolbarContainer({
    super.key,
    this.child,
    required this.selection,
    required this.docLayoutKey,
    required this.editorScrollController,
    required this.isMobile,
    required this.onCloseKeyboard,
  });

  final Widget? child;
  final DocumentSelection selection;
  final GlobalKey docLayoutKey;
  final ScrollController editorScrollController;
  final bool isMobile;
  final void Function() onCloseKeyboard;

  bool get isSingleSelection {
    return selection.base.nodeId == selection.extent.nodeId;
  }

  // 選択範囲のtopCenterの位置を取得
  Offset? calcAnchor(RenderBox stackBox) {
    if (docLayoutKey.currentState == null || selection.isCollapsed) {
      return null;
    }
    final selectionRect = (docLayoutKey.currentState as DocumentLayout?)
        ?.getRectForSelection(selection.base, selection.extent)!;
    final docBox = docLayoutKey.currentContext!.findRenderObject();
    if (selectionRect != null && docBox is RenderBox) {
      final globalSelectionRect = Rect.fromPoints(
        docBox.localToGlobal(selectionRect.topLeft),
        docBox.localToGlobal(selectionRect.bottomRight),
      );
      return stackBox.globalToLocal(globalSelectionRect.topCenter);
    }
    return null;
  }

  // GlobalKeyからRenderBoxを取得
  RenderBox? findRenderBox(GlobalKey key) {
    // print('findRenderBox $key');
    final renderer = key.currentContext?.findRenderObject();
    if (renderer is RenderBox) {
      return renderer;
    }
    return null;
  }

  // ToolbarのtopLeft位置を取得
  Offset? calcPosition({
    required RenderBox toolbarBox,
    required Offset anchor,
    required RenderBox stackBox,
  }) {
    final toolbarRect = Rect.fromCenter(
      center: anchor.translate(0, -toolbarBox.size.height),
      width: toolbarBox.size.width,
      height: toolbarBox.size.height,
    );
    Offset? offset = toolbarRect.topLeft;
    final stackRect = Offset.zero & stackBox.size;
    if (toolbarRect.left < stackRect.left) {
      offset = Offset(stackRect.left, offset.dy);
    }
    if (stackRect.right < toolbarRect.right) {
      offset = Offset(stackRect.right - toolbarRect.width, offset.dy);
    }
    if (toolbarRect.top < stackRect.top) {
      offset = Offset(offset.dx, stackRect.top);
    }
    if (stackRect.bottom < toolbarRect.bottom) {
      offset = Offset(offset.dx, stackRect.bottom - toolbarRect.height);
    }
    return offset;
  }

  @override
  Widget build(BuildContext context) {
    // print('render ToolbarContainer');
    final anchor = useState<Offset?>(null);
    final position = useState<Offset?>(null);
    final stackKey = useMemoized(() => GlobalKey());
    final toolbarKey = useMemoized(() => GlobalKey());
    final stackBox = useState<RenderBox?>(null);
    final toolbarBox = useState<RenderBox?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        stackBox.value = findRenderBox(stackKey);
        toolbarBox.value = findRenderBox(toolbarKey);
        if (stackBox.value != null && stackBox.value!.size > Size.zero) {
          anchor.value = calcAnchor(stackBox.value!);
          if (anchor.value != null && toolbarBox.value != null) {
            position.value = calcPosition(
              anchor: anchor.value!,
              stackBox: stackBox.value!,
              toolbarBox: toolbarBox.value!,
            );
          }
        }
      });
      return null;
    }, [stackBox.value, toolbarBox.value, selection]);

    // スクロールされたらanchorを再計算
    final editorScrollControllerListener = useCallback(() {
      if (stackBox.value != null && stackBox.value!.size > Size.zero) {
        anchor.value = calcAnchor(stackBox.value!);
      }
    }, [stackBox.value, selection]);
    useEffect(() {
      editorScrollController.addListener(editorScrollControllerListener);
      return () {
        editorScrollController.removeListener(editorScrollControllerListener);
      };
    });

    // selectionが画面外にスクロールされたとき、ツールバーを非表示にする
    // final isVisible = true;
    final isVisible = useMemoized(
      () {
        if (anchor.value == null || stackBox.value == null) {
          return false;
        }
        if (!isSingleSelection) {
          return false;
        }
        if (anchor.value!.dy < -100) {
          return false;
        }
        if (anchor.value!.dy > stackBox.value!.size.height + 100) {
          return false;
        }
        return true;
      },
      [
        anchor.value,
        anchor.value?.dy,
        isSingleSelection,
        stackBox.value,
        stackBox.value?.size.height,
      ],
    );

    buildPositioned({required Widget child}) {
      if (isMobile) {
        return Positioned(
          key: toolbarKey,
          left: 0,
          right: 0,
          bottom: 0,
          child: child,
        );
      }
      return Positioned(
        key: toolbarKey,
        left: position.value?.dx,
        top: position.value?.dy,
        child: child,
      );
    }

    buildToolbar() {
      final toolbar = AnimatedOpacity(
        opacity: !isVisible ? 0.0 : 1.0,
        alwaysIncludeSemantics: true,
        duration: const Duration(milliseconds: 100),
        child: IgnorePointer(
          ignoring: !isVisible,
          ignoringSemantics: true,
          child: child,
        ),
      );
      if (isMobile) {
        return ToolbarKeyboard(
          isMobile: isMobile,
          onCloseKeyboard: onCloseKeyboard,
          child: toolbar,
        );
      }
      return toolbar;
    }

    return Stack(
      key: stackKey,
      fit: StackFit.expand,
      children: [
        buildPositioned(
          child: buildToolbar(),
        ),
      ],
    );
  }
}
