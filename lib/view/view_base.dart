import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

typedef ViewBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

class ViewBase<T> {
  final String path;

  final ViewBuilder builder;

  const ViewBase(this.path, this.builder);
}
