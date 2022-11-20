import 'package:flutter/material.dart';
import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/video/video_list.dart';
import 'package:memo_app/view/video/video_playback.dart';
import 'package:memo_app/view/view_base.dart';

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

class Routes {
  static List<NavigatorRoute> get values => [
        home,
        about,
        player,
        videoGallery,
      ];

  static final home = NavigatorRoute(HomeView());

  static final about = NavigatorRoute(AboutView());

  static final player = NavigatorRoute(VideoPlaybackView());

  static final videoGallery = NavigatorRoute(VideoListView());
}

final routes = {
  for (final r in Routes.values) r.name: r.builder,
};
