import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/editor/editor.dart';
import 'package:memo_app/component/editor/my_editor.dart';

class Home extends HookConsumerWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next',
            onPressed: () {
              Navigator.pushNamed(context, '/overlay');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // MyEditor(),
          Editor(),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: counterNotifier.incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
