import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SwitchButtonItem<T extends Object> {
  final T value;
  final String label;

  const SwitchButtonItem({required this.label, required this.value});
}

class ActiveColor {
  static Color get textColor => Colors.white;
  static Color get backgroundColor => Colors.blue;
}

class DisabledColor {
  static Color get textColor => Colors.black;
  static Color get backgroundColor => Colors.transparent;
}

const defaultList = [
  SwitchButtonItem(label: 'メイン', value: '0'),
  SwitchButtonItem(label: 'スイッチ', value: '180'),
];

class SwitchButton extends HookWidget {
  final List<SwitchButtonItem> list;
  final double height;
  final double itemExtent;
  final void Function(SwitchButtonItem)? onChange;

  const SwitchButton({
    Key? key,
    this.list = defaultList,
    this.height = 50,
    this.itemExtent = 80.0,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentItem = useState<SwitchButtonItem>(list[0]);

    final toggleChange = useCallback(() {
      final index = list.indexOf(currentItem.value);
      if (index + 1 >= list.length) {
        currentItem.value = list[0];
      } else {
        currentItem.value = list[index + 1];
      }
      if (onChange != null) {
        onChange!(list[index + 1]);
      }
    }, [currentItem.value, list]);

    Widget itemBuilder(SwitchButtonItem item, {isActive = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text(
          item.label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey.shade500,
          ),
        ),
      );
    }

    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: toggleChange,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            children: List.generate(
              list.length * 2 - 1,
              (index) => index,
            ).map((i) {
              if (i.isEven) {
                return itemBuilder(
                  list[i ~/ 2],
                  isActive: currentItem.value == list[i ~/ 2],
                );
              } else {
                return Container(
                  width: 1,
                  height: 16,
                  color: Colors.grey.shade500,
                );
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}
