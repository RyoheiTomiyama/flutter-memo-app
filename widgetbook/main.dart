import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/component/editor/my_editor.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';
import 'package:memo_app/ui/layout/scrollable_sheet.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'elevated',
                  builder: (context) => ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      context.knobs
                          .number(
                            label: 'hello',
                          )
                          .toString(),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'SuperEditor',
                  builder: (context) => const MyEditor(),
                ),
                WidgetbookUseCase(
                  name: 'ScrollableSheet',
                  builder: (context) => PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Material(
                        color: Theme.of(context).errorColor,
                      ),
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          const ScrollableSheet(),
                        ],
                      ),
                      SwipeUpPanel(
                        body: Text('Hello body!'),
                        child: Text('Hello panel'),
                      )
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'ScrollableSheet2',
                  builder: (context) => Stack(
                    fit: StackFit.expand,
                    children: [
                      const ScrollableSheet(),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'ScrollableBottomSheet',
                  builder: (context) => const Scaffold(
                    backgroundColor: Colors.red,
                    body: SwipeUpPanel(
                      body: Text('Hello body!'),
                      child: Text('Hello panel'),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'GestureDetectorにイベントが伝播しない例',
                  builder: (context) => GestureDetector(
                    onVerticalDragStart: (details) {
                      print('drag start');
                    },
                    onVerticalDragUpdate: (details) {
                      print('drag update');
                    },
                    onVerticalDragEnd: (details) {
                      print('drag end');
                    },
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(color: Colors.amber, height: 500),
                        Container(color: Colors.blue, height: 500),
                        Container(color: Colors.red, height: 500),
                      ]),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'GestureDetectorでスクロールをコントロールしている例',
                  builder: (context) {
                    final scrollController = ScrollController();
                    Drag? drag;
                    return GestureDetector(
                      // excludeFromSemantics: true,
                      onVerticalDragStart: (details) {
                        print('drag start');
                        drag = scrollController.position.drag(details, () {});
                      },
                      onVerticalDragUpdate: (details) {
                        print('drag update');
                        drag?.update(details);
                      },
                      onVerticalDragEnd: (details) {
                        print('drag end');
                        drag?.end(details);
                        drag = null;
                      },
                      child: SingleChildScrollView(
                        // ここではスクロールさせない設定にしてGestureDetectorにイベントを渡してスクロール制御する
                        physics: const NeverScrollableScrollPhysics(
                          parent: ClampingScrollPhysics(),
                        ),
                        controller: scrollController,
                        child: Column(children: [
                          Container(color: Colors.amber, height: 500),
                          Container(color: Colors.blue, height: 500),
                          Container(color: Colors.red, height: 500),
                        ]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      devices: [Apple.iPhone12ProMax, Apple.iPhone8Plus],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
