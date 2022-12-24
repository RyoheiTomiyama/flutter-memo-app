import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GalleryGridView extends HookWidget {
  final int? itemCount;
  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController? scrollController;

  const GalleryGridView({
    super.key,
    this.itemCount,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      childAspectRatio: 1,
    ),
    required this.itemBuilder,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder,
      cacheExtent: 400,
    );
  }
}
