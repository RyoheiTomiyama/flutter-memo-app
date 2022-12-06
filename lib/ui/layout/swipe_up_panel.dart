import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/ui/layout/swipe_up_panel/panel.dart';

class SwipeUpPanel extends HookWidget {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget? child;
  final Widget? body;
  final ScrollController? scrollController;

  const SwipeUpPanel(
      {super.key,
      this.initialChildSize = 0.4,
      this.minChildSize = 0.4,
      this.maxChildSize = 0.9,
      this.child,
      this.body,
      this.scrollController});

  Widget buildBody({
    required double minHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight, maxHeight: minHeight),
      // child: IntrinsicHeight(
      child: SizedBox(
        width: double.infinity,
        child: body,
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFullOpened = useState(false);
    final sc = scrollController ?? useScrollController();
    final panelController = useScrollController();
    final drag = useState<Drag?>(null);
    final panelDrag = useState<Drag?>(null);

    final cancelDrag = useCallback(() {
      drag.value?.cancel();
      drag.value = null;
    }, [drag.value]);

    final scrollTo = useCallback((double to) {
      const duration = Duration(milliseconds: 300);
      cancelDrag();
      sc.position.moveTo(to, duration: duration);
    }, [sc, cancelDrag]);

    return LayoutBuilder(builder: (context, constraints) {
      // Panelの最大高
      final maxHeight = constraints.maxHeight * maxChildSize;
      // Panelが展開される高さ
      final borderHeight = constraints.maxHeight * minChildSize;
      return GestureDetector(
        // excludeFromSemantics: true,
        onVerticalDragStart: (details) {
          drag.value = sc.position.drag(details, () {});
          panelDrag.value = panelController.position.drag(details, () {});
          isFullOpened.value = sc.position.pixels >= maxHeight;
        },
        onVerticalDragUpdate: (details) {
          isFullOpened.value = sc.position.pixels >= maxHeight;
          if (isFullOpened.value) {
            panelDrag.value?.update(details);
          }
          if (!isFullOpened.value ||
              panelController.position.extentBefore == 0) {
            drag.value?.update(details);
          }
        },
        onVerticalDragEnd: (details) {
          isFullOpened.value = sc.position.pixels >= maxHeight;
          if (isFullOpened.value &&
              panelController.position.extentBefore != 0) {
            panelDrag.value?.end(details);
            panelDrag.value = null;
            cancelDrag();
          } else {
            panelDrag.value?.cancel();
            panelDrag.value = null;
            if (sc.position.pixels < borderHeight) {
              // panelがborderHeightより下にいるとき
              if (details.velocity.pixelsPerSecond.dy < -6) {
                // 上スクロール
                scrollTo(borderHeight);
                return;
              }
              if (details.velocity.pixelsPerSecond.dy > 6) {
                // 下スクロール
                scrollTo(0);
                return;
              }
              // panelを閉じるか展開するか
              if (sc.position.pixels > borderHeight / 2) {
                scrollTo(borderHeight);
                return;
              } else {
                scrollTo(0);
                return;
              }
            } else {
              // panelがborderHeightより上にいるとき
              if (details.velocity.pixelsPerSecond.dy > 10) {
                // 下スクロール

                // velocityはスクロールの強さ
                final simulation = ClampingScrollSimulation(
                  position: sc.position.pixels,
                  velocity: -details.velocity.pixelsPerSecond.dy,
                );
                if (simulation.x(10) < borderHeight) {
                  // 慣性スクロールの終了地点がboderHeightより下になるとき
                  scrollTo(borderHeight);
                }
              }
            }
            drag.value?.end(details);
            panelDrag.value = null;
          }
        },
        child: SingleChildScrollView(
          // ここではスクロールさせない設定にしてGestureDetectorにイベントを渡してスクロール制御する
          physics: const NeverScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          controller: sc,
          child: Column(
            children: [
              buildBody(
                minHeight: constraints.maxHeight,
              ),
              Panel(
                controller: panelController,
                maxHeight: maxHeight,
                isFullOpened: isFullOpened.value,
                child: child,
              ),
            ],
          ),
        ),
      );
    });
  }
}
