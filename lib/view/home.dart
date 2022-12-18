import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/component/editor/my_editor.dart';
import 'package:memo_app/routes.dart';
import 'package:memo_app/view/view_base.dart';

class HomeView implements ViewBase {
  @override
  ViewBuilder get builder => (context, state) {
        return const Home(
          title: 'This is Home',
        );
      };

  @override
  String get path => '/';
}

//
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
              context.goNamed(AppRoute.about.name);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MyEditor(),
          // Editor(),
          Column(
            children: [
              Container(
                  color: Theme.of(context).primaryColor, width: 50, height: 50),
              Container(color: Colors.blueGrey.shade700, width: 50, height: 50),
              Container(
                  color: Theme.of(context).primaryColorDark,
                  width: 50,
                  height: 50),
            ],
          )
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
