import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollPickerItem<T extends Object> {
  final T value;
  final String label;

  const ScrollPickerItem({required this.label, required this.value});
}

class HeavyFixedExtentScrollPhysics extends FixedExtentScrollPhysics {
  const HeavyFixedExtentScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  HeavyFixedExtentScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return HeavyFixedExtentScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    return super.createBallisticSimulation(position, velocity / 2);
  }
}

class ScrollPicker<R extends Object> extends HookWidget {
  final R? value;
  final List<ScrollPickerItem<R>> list;
  final double height;
  final double itemExtent;
  final void Function(R)? onChange;

  const ScrollPicker({
    Key? key,
    this.value,
    required this.list,
    this.height = 50,
    this.itemExtent = 80.0,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentValue = useState<R?>(value);
    final tapUpX = useState(0.0);
    // final currentItem = useState<ScrollPickerItem>(list[2]);
    final initialItem = useMemoized(() {
      return list
          .indexWhere(
            (item) => item.value == value,
          )
          .clamp(0, list.length);
    }, [list, currentValue.value]);
    final controller = useState(
      FixedExtentScrollController(initialItem: initialItem),
    );

    final getClickedIndex = useCallback((
      double listWidth,
      double tapX,
      double scrollX,
    ) {
      // 0番目の左の余白スペース
      final spaceX = (listWidth - itemExtent) / 2;
      final clickedX = tapX - spaceX + scrollX;
      return (clickedX / itemExtent).floor();
    }, [itemExtent]);

    return Expanded(
      child: Container(
        height: height,
        child: Stack(
          children: [
            Center(
                child: Stack(
              children: [
                Container(
                  transform: Transform.translate(
                    offset: const Offset(0, 20),
                  ).transform,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.height_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            )),
            RotatedBox(
              quarterTurns: 3,
              child: GestureDetector(
                onTap: () {
                  final index = getClickedIndex(
                    controller.value.position.viewportDimension,
                    tapUpX.value,
                    controller.value.offset,
                  );
                  if (0 <= index && index < list.length) {
                    currentValue.value = list[index].value;
                    controller.value.animateToItem(
                      index,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                    if (onChange != null && currentValue.value != null) {
                      onChange!(currentValue.value!);
                    }
                  }
                },
                onTapUp: (details) {
                  // Rotatedで90度回転しているからdyでX軸のポジションを取得
                  tapUpX.value = details.localPosition.dy;
                },
                child: ListWheelScrollView(
                  controller: controller.value,
                  itemExtent: itemExtent,
                  diameterRatio: 100,
                  // overAndUnderCenterOpacity: 0.2,
                  physics: const HeavyFixedExtentScrollPhysics(),
                  renderChildrenOutsideViewport: false,
                  onSelectedItemChanged: (i) {
                    // currentItem.value = list[i];
                    currentValue.value = list[i].value;
                    if (onChange != null && currentValue.value != null) {
                      onChange!(currentValue.value!);
                    }
                  },
                  children: list.map((e) {
                    return ScrollPickerItemWidget(
                      item: e,
                      isActive: currentValue.value == e.value,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollPickerItemWidget<R extends Object> extends HookWidget {
  final ScrollPickerItem<R> item;
  final bool isActive;

  const ScrollPickerItemWidget({
    super.key,
    required this.item,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        alignment: Alignment.center,
        // color: Colors.amber,
        child: Text(
          item.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
          strutStyle: const StrutStyle(leading: 0.5),
        ),
      ),
    );
  }
}
