import 'package:flutter/material.dart';
import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/video/video_list.dart';
import 'package:memo_app/view/video/video_playback.dart';

class NavigatorRoute {
  final String name;

  final WidgetBuilder builder;

  NavigatorRoute(this.name, this.builder);
}

class Routes {
  static List<NavigatorRoute> get values => [
        home,
        about,
        player,
        videoGallery,
      ];

  static final home = NavigatorRoute(
    '/',
    (context) => const Home(title: 'Flutter Demo Home Page'),
  );

  static final about = NavigatorRoute(
    '/about',
    (context) => const About(title: 'Flutter Demo About Page'),
  );

  static final player = NavigatorRoute(
    '/player',
    (context) => const VideoPlayback(),
  );

  static final videoGallery = NavigatorRoute(
    '/video-gallery',
    (context) => const VideoList(),
  );
}

final routes = {
  for (final r in Routes.values) r.name: r.builder,
};
