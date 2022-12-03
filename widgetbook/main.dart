import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/component/editor/my_editor.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';
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
                  name: 'SwipeUpPanel',
                  builder: (context) => const Scaffold(
                    backgroundColor: Colors.red,
                    body: SwipeUpPanel(
                      body: Text('Hello body!'),
                      child: Text('Hello panel'),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'GestureDetector実験',
              useCases: [
                WidgetbookUseCase(
                  name: 'ドラッグイベントが伝播しない通常例',
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
                  name: 'スクロールをコントロールしている例',
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
            WidgetbookComponent(
              name: 'NestedScroll実験',
              useCases: [
                WidgetbookUseCase(
                  name: 'Doc',
                  builder: (context) {
                    return Scaffold(
                      // body: LayoutBuilder(
                      //   builder: (context, constraints) {
                      //     // SliverLayoutBuilder(builder: (context, constraints) {
                      //     // // Panelの最大高
                      //     // final maxHeight =
                      //     //     constraints.maxHeight * maxChildSize;
                      //     // // Panelが展開される高さ
                      //     // final borderHeight =
                      //     //     constraints.maxHeight * minChildSize;
                      //     Widget buildBody({
                      //       required double minHeight,
                      //     }) {
                      //       return ConstrainedBox(
                      //         constraints: BoxConstraints(
                      //             minHeight: minHeight, maxHeight: minHeight),
                      //         // child: IntrinsicHeight(
                      //         child: SizedBox(
                      //           width: double.infinity,
                      //           child: Container(),
                      //         ),
                      //         // ),
                      //       );
                      //     }

                      //     return NestedScrollView(
                      //       // Setting floatHeaderSlivers to true is required in order to float
                      //       // the outer slivers over the inner scrollable.
                      //       floatHeaderSlivers: false,
                      //       headerSliverBuilder: (BuildContext context,
                      //           bool innerBoxIsScrolled) {
                      //         return <Widget>[
                      //           SliverToBoxAdapter(
                      //             child: GestureDetector(
                      //               child: SingleChildScrollView(
                      //                 // ここではスクロールさせない設定にしてGestureDetectorにイベントを渡してスクロール制御する
                      //                 physics:
                      //                     const NeverScrollableScrollPhysics(
                      //                   parent: ClampingScrollPhysics(),
                      //                 ),
                      //                 // controller: sc,
                      //                 child: Column(
                      //                   children: [
                      //                     buildBody(
                      //                       minHeight: constraints.maxHeight,
                      //                     ),
                      //                     // buildPanel(context, maxHeight: maxHeight),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // Player(id: ''),
                      //         ];
                      //       },
                      //       body: ListView.builder(
                      //         physics: ClampingScrollPhysics(),
                      //         padding: const EdgeInsets.all(8),
                      //         itemCount: 30,
                      //         itemBuilder: (BuildContext context, int index) {
                      //           return SizedBox(
                      //             height: 50,
                      //             child: Center(child: Text('Item $index')),
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      body: LayoutBuilder(
                        builder: (context, constraints) {
                          // print(constraints.maxHeight);
                          // SliverLayoutBuilder(builder: (context, constraints) {
                          // // Panelの最大高
                          // final maxHeight =
                          //     constraints.maxHeight * maxChildSize;
                          // // Panelが展開される高さ
                          // final borderHeight =
                          //     constraints.maxHeight * minChildSize;
                          Widget buildBody({
                            required double minHeight,
                          }) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: minHeight, maxHeight: minHeight),
                              // child: IntrinsicHeight(
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  // height: constraints.maxHeight,
                                  color: Colors.transparent,
                                  child: Text('hello world'),
                                ),
                              ),
                              // ),
                            );
                          }

                          return NestedScrollView(
                            // Setting floatHeaderSlivers to true is required in order to float
                            // the outer slivers over the inner scrollable.
                            floatHeaderSlivers: false,
                            physics: const NeverScrollableScrollPhysics(
                              parent: ClampingScrollPhysics(),
                            ),
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverAppBar(
                                  elevation: 0,
                                  pinned: true,
                                  backgroundColor: Colors.transparent,
                                  flexibleSpace: Container(
                                    height: 100,
                                    // color: Colors.blue,
                                    child: buildBody(
                                        minHeight: constraints.maxHeight),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                    height: constraints.maxHeight,
                                    color: Colors.blue,
                                    child: buildBody(
                                        minHeight: constraints.maxHeight),
                                  ),
                                ),
                                // Player(id: ''),
                              ];
                            },
                            body: Container(
                              height: 400,
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: 30,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 50,
                                        child:
                                            Center(child: Text('Item $index')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
