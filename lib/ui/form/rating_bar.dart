import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// 0 ~ 10
// Odd is half star
class RatingBar extends HookWidget {
  final int value;
  final int maxValue;
  final bool makeHalf;
  final void Function(int)? onChange;
  const RatingBar({
    super.key,
    this.value = 3,
    this.maxValue = 10,
    this.makeHalf = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final num = makeHalf ? 2 : 1;
    final count = (maxValue / num).ceil();

    final calcValue = useCallback((double x) {
      final width = context.size?.width ?? 100;
      final posX = x.clamp(0, width);
      final nextValue = (posX / (width / maxValue)).ceil();
      return nextValue;
    }, []);

    final updateNotify = useCallback((int nextValue) {
      // print('update $nextValue');
      if (onChange != null) {
        onChange!(nextValue);
      }
    }, [onChange]);
    return GestureDetector(
      // onHorizontalDragStart: (details) {},
      onHorizontalDragUpdate: (details) {
        final nextValue = calcValue(details.localPosition.dx);
        updateNotify(nextValue);
      },
      // onHorizontalDragEnd: (details) {},
      onTapUp: (details) {
        final nextValue = calcValue(details.localPosition.dx);
        if (value == nextValue) {
          updateNotify((nextValue - 1).clamp(0, maxValue));
        } else {
          updateNotify(nextValue);
        }
      },
      child: Row(
        children: List.generate(count, (i) => i + 1).map(((i) {
          if (i * num <= value) {
            return const RatingBarWidget(status: RatingWidgetStatus.full);
          } else if (makeHalf && i * num - 1 == value) {
            return const RatingBarWidget(status: RatingWidgetStatus.half);
          }
          return const RatingBarWidget(status: RatingWidgetStatus.empty);
        })).toList(),
        // children: [
        //   RatingBarWidget(status: RatingWidgetStatus.full),
        //   RatingBarWidget(status: RatingWidgetStatus.full),
        //   RatingBarWidget(status: RatingWidgetStatus.full),
        //   RatingBarWidget(status: RatingWidgetStatus.half),
        //   RatingBarWidget(status: RatingWidgetStatus.empty),
        // ],
      ),
    );
  }
}

enum RatingWidgetStatus {
  empty,
  half,
  full,
}

class RatingBarWidget extends HookWidget {
  final RatingWidgetStatus status;
  const RatingBarWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    const full = Icons.star_rounded;
    const half = Icons.star_half_rounded;
    const empty = Icons.star_border_rounded;
    final icon = useState(empty);
    useEffect(() {
      switch (status) {
        case RatingWidgetStatus.empty:
          icon.value = empty;
          break;
        case RatingWidgetStatus.half:
          icon.value = half;
          break;
        case RatingWidgetStatus.full:
          icon.value = full;
          break;
        default:
          break;
      }
    }, [status]);
    return Container(
      child: Icon(
        icon.value,
        size: 32,
      ),
    );
  }
}
