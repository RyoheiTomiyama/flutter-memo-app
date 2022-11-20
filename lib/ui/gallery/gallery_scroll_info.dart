import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GalleryScrollInfo extends HookWidget {
  final String? value;
  const GalleryScrollInfo({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            value ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
