import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GalleryAlbumDropdown<T extends Object> extends HookWidget {
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final T? value;

  const GalleryAlbumDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.white,
      ),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
