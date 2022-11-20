import 'package:flutter/widgets.dart';

typedef ViewBuilder<T extends Object?> = Widget Function(
  BuildContext context, {
  T? args,
});

class ViewBase<T> {
  final String name;

  final ViewBuilder<T> builder;

  const ViewBase(this.name, this.builder);
}
