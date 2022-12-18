import 'package:flutter/material.dart';
import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/ui.dart';
import 'package:memo_app/view/video/video_list.dart';
import 'package:memo_app/view/video/video_playback.dart';
import 'package:memo_app/view/view_base.dart';

// argumentsを渡すため
class NavigatorRoute {
  late String name;

  late WidgetBuilder builder;

  NavigatorRoute(ViewBase view) {
    name = view.name;
    builder = ((context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      return view.builder(context, args: args);
    });
  }
}

enum AppRoute {
  home,
  about,
  player,
  videoGallery,
  ui,
}

extension AppRouteExt on AppRoute {
  String get name => _routes[this]?.name ?? '';
  // TODO error page
  WidgetBuilder get builder => _routes[this]?.builder ?? (_) => Container();

  static final _routes = {
    AppRoute.home: NavigatorRoute(HomeView()),
    AppRoute.about: NavigatorRoute(AboutView()),
    AppRoute.player: NavigatorRoute(VideoPlaybackView()),
    AppRoute.videoGallery: NavigatorRoute(VideoListView()),
    AppRoute.ui: NavigatorRoute(UiView()),
  };
}

final routes = {
  for (final r in AppRoute.values) r.name: r.builder,
};
