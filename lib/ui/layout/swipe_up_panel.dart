import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

  Widget buildPanel(
    BuildContext context, {
    required double maxHeight,
  }) {
    return Container(
      width: double.infinity,
      height: maxHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 30,
              height: 3,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
          child ?? Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sc = scrollController ?? useScrollController();
    final drag = useState<Drag?>(null);

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
        },
        onVerticalDragUpdate: (details) {
          drag.value?.update(details);
        },
        onVerticalDragEnd: (details) {
          // print(details.velocity.pixelsPerSecond.dy);
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
          drag.value = null;
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
              buildPanel(context, maxHeight: maxHeight),
            ],
          ),
        ),
      );
    });
  }
}
