import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GalleryScrollbar extends HookWidget {
  final Widget child;

  final ScrollController? controller;

  const GalleryScrollbar({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: true,
      trackVisibility: false,
      thickness: 8,
      radius: const Radius.circular(4),
      interactive: true,
      // scrollbarOrientation: scrollbarOrientation,
      child: child,
    );
  }
}

// スクロールバーのデザインを変えたい場合

// const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
// const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

// class _GalleryScrollbar extends RawScrollbar {
//   const _GalleryScrollbar({
//     required super.child,
//     super.controller,
//     super.thumbVisibility,
//     super.trackVisibility,
//     super.thickness,
//     super.radius,
//     ScrollNotificationPredicate? notificationPredicate,
//     super.interactive,
//     super.scrollbarOrientation,
//   }) : super(
//         // fadeDuration: _kScrollbarFadeDuration,
//         // timeToFade: _kScrollbarTimeToFade,
//         // pressDuration: Duration.zero,
//         // notificationPredicate:
//         //     notificationPredicate ?? defaultScrollNotificationPredicate,
//         );

//   // @override
//   // _GalleryScrollbarState createElement() => _GalleryScrollbarState();

//   @override
//   _GalleryScrollbarState createState() => _GalleryScrollbarState();
// }

// class _GalleryScrollbarState extends RawScrollbarState<_GalleryScrollbar> {
//   Color get _trackColor {
//     return widget.trackVisibility ?? false
//         ? Colors.black.withOpacity(0.6)
//         : Colors.transparent;
//   }

//   @override
//   void updateScrollbarPainter() {
//     scrollbarPainter
//       ..color = Colors.black.withOpacity(0.8)
//       ..trackColor = _trackColor
//       ..trackBorderColor = _trackColor
//       ..textDirection = Directionality.of(context)
//       ..thickness = widget.thickness ?? 6
//       ..radius = widget.radius
//       // ..crossAxisMargin = _scrollbarTheme.crossAxisMargin ??
//       //     (_useAndroidScrollbar ? 0.0 : _kScrollbarMargin)
//       // ..mainAxisMargin = _scrollbarTheme.mainAxisMargin ?? 0.0
//       // ..minLength = _scrollbarTheme.minThumbLength ?? _kScrollbarMinLength
//       ..padding = MediaQuery.of(context).padding
//       ..scrollbarOrientation = widget.scrollbarOrientation
//       ..ignorePointer = !enableGestures;
//   }

//   @override
//   void initState() {
//     widget.controller?.addListener(() {
//       print(widget.controller?.offset);
//       // print(scrollbarPainter);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return super.build(context);
//   }
// }
