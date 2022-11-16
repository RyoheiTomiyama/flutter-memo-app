import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollableSheet extends HookWidget {
  const ScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        // return SingleChildScrollView(
        //   physics: const ClampingScrollPhysics(),
        //   controller: scrollController,
        //   child: Material(
        //     child: SizedBox(height: 1000),
        //     color: Theme.of(context).primaryColor,
        //   ),
        // );
        return ListView.builder(
          primary: false,
          controller: scrollController,
          itemCount: 1,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Material(
              child: SizedBox(height: 1000),
              color: Theme.of(context).primaryColor,
            );
          },
        );
      },
    );
  }
}
