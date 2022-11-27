import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/ui/form/rating_bar.dart';
import 'package:memo_app/ui/form/scroll_picker.dart';
import 'package:memo_app/ui/form/switch_button.dart';
import 'package:memo_app/view/view_base.dart';

class UiView implements ViewBase {
  @override
  ViewBuilder get builder => (context, {args}) => const Ui();

  @override
  String get name => '/ui';
}

class Ui extends HookWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('スタンス'),
                ),
                SwitchButton(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('回転数'),
                ),
                ScrollPicker(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('アプローチ'),
                ),
                RatingBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
