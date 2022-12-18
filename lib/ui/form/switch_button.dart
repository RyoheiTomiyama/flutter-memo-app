import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SwitchButtonItem<T extends Object> {
  final T value;
  final String label;

  const SwitchButtonItem({required this.label, required this.value});
}

class SwitchButton<R extends Object> extends HookWidget {
  // final value;
  final List<SwitchButtonItem<R>> list;
  final R? value;
  final double height;
  final double itemExtent;
  final void Function(R)? onChange;

  const SwitchButton({
    Key? key,
    required this.list,
    this.value,
    this.height = 50,
    this.itemExtent = 80.0,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final handleChange = useCallback((R v) {
      onChange?.call(v);
    }, [onChange]);

    Widget itemBuilder(SwitchButtonItem<R> item, {isActive = false}) {
      return InkWell(
        onTap: () => handleChange(item.value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            item.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: List.generate(
          list.length * 2 - 1,
          (index) => index,
        ).map((i) {
          if (i.isEven) {
            return itemBuilder(
              list[i ~/ 2],
              isActive: value == list[i ~/ 2].value,
            );
          } else {
            return Container(
              width: 1,
              height: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            );
          }
        }).toList(),
      ),
    );
  }
}
