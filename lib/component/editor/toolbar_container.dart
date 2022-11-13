import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/component/editor/toolbar.dart';
import 'package:super_editor/super_editor.dart';

class ToolbarContainer extends HookWidget {
  const ToolbarContainer({
    super.key,
    this.child,
    required this.selection,
    required this.docLayoutKey,
    required this.editorScrollController,
  });

  final Widget? child;
  final DocumentSelection selection;
  final GlobalKey docLayoutKey;
  final ScrollController editorScrollController;

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
            // print(
            //     'position: ${position.value} ${anchor.value} ${stackBox.value?.size} ${toolbarBox.value?.size}');
          }
        }
      });
    });

    // スクロールされたらanchorを再計算
    final editorScrollControllerListener = useCallback(() {
      if (stackBox.value != null && stackBox.value!.size > Size.zero) {
        anchor.value = calcAnchor(stackBox.value!);
      }
    }, []);
    useEffect(() {
      editorScrollController.addListener(editorScrollControllerListener);
      return () {
        editorScrollController.removeListener(editorScrollControllerListener);
      };
    });

    // selectionが画面外にスクロールされたとき、ツールバーを非表示にする
    final isVisible = position.value != null &&
        anchor.value != null &&
        (((position.value! - anchor.value!).dy +
                    (toolbarBox.value?.size.height ?? 0))
                .abs() <
            100);

    return Stack(
      key: stackKey,
      // fit: StackFit.expand,
      children: [
        Positioned(
          key: toolbarKey,
          left: position.value?.dx,
          top: position.value?.dy,
          child: AnimatedOpacity(
            opacity: !isVisible ? 0 : 1,
            duration: const Duration(milliseconds: 100),
            child: child,
          ),
        ),
      ],
    );
  }
}
