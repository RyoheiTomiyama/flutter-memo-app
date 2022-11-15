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
      constraints: BoxConstraints(minHeight: minHeight),
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          // height: context.size?.height,
          color: Colors.amber,
          child: body,
        ),
      ),
    );
  }

  Widget buildPanel(
    BuildContext context, {
    required double maxHeight,
  }) {
    return Container(
      width: double.infinity,
      height: maxHeight,
      color: Theme.of(context).primaryColor,
      child: child ??
          ListView.builder(
            primary: false,
            itemCount: 30,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Theme.of(context).primaryColor,
                child: SizedBox(
                  height: 100,
                  child: Text(index.toString()),
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sc = scrollController ?? useScrollController();
    final drag = useState<Drag?>(null);

    return LayoutBuilder(builder: (context, constraints) {
      final maxHeight = constraints.maxHeight * maxChildSize;
      final borderHeight = constraints.maxHeight * minChildSize;
      return GestureDetector(
        // excludeFromSemantics: true,
        onVerticalDragStart: (details) {
          print('drag start');
          drag.value = sc.position.drag(details, () {});
        },
        onVerticalDragUpdate: (details) {
          print(details.delta);
          drag.value?.update(details);
        },
        onVerticalDragEnd: (details) {
          print(details);
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
