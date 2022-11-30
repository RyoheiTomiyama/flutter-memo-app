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

const defaultList = [
  ScrollPickerItem(label: 'ストレート', value: '0'),
  ScrollPickerItem(label: '180°', value: '180'),
  ScrollPickerItem(label: '360°', value: '360'),
  ScrollPickerItem(label: '540°', value: '540'),
  ScrollPickerItem(label: '720°', value: '720'),
  ScrollPickerItem(label: '900°', value: '900'),
  ScrollPickerItem(label: '1080°', value: '1080'),
  ScrollPickerItem(label: '1260°', value: '1260'),
];

class ScrollPicker extends HookWidget {
  final List<ScrollPickerItem> list;
  final double height;
  final double itemExtent;
  final void Function(ScrollPickerItem)? onChange;
  const ScrollPicker({
    Key? key,
    this.list = defaultList,
    this.height = 50,
    this.itemExtent = 80.0,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentItem = useState<ScrollPickerItem>(list[2]);

    final controller = useState(FixedExtentScrollController(initialItem: 2));

    return Expanded(
      child: Container(
        height: height,
        // color: Colors.amber,
        child: Stack(
          children: [
            Container(
              child: Center(
                  child: Stack(
                children: [
                  // Container(
                  //   transform:
                  //       Transform.translate(offset: Offset(0, -20)).transform,
                  //   child: Icon(
                  //     Icons.keyboard_arrow_down_rounded,
                  //     color: Theme.of(context).colorScheme.primary,
                  //   ),
                  // ),
                  Container(
                    transform:
                        Transform.translate(offset: Offset(0, 20)).transform,
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
            ),
            RotatedBox(
              quarterTurns: 3,
              child: ListWheelScrollView(
                controller: controller.value,
                itemExtent: itemExtent,
                diameterRatio: 100,
                // overAndUnderCenterOpacity: 0.2,
                physics: const HeavyFixedExtentScrollPhysics(),
                renderChildrenOutsideViewport: false,
                onSelectedItemChanged: (i) {
                  currentItem.value = list[i];
                  if (onChange != null) {
                    onChange!(list[i]);
                  }
                },
                children: list.map((e) {
                  return ScrollPickerItemWidget(
                    item: e,
                    isActive: currentItem.value.value == e.value,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollPickerItemWidget extends HookWidget {
  final ScrollPickerItem item;
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
