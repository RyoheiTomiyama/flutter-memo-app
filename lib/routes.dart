import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/ui.dart';
import 'package:memo_app/view/video/video_list.dart';
import 'package:memo_app/view/video/video_playback.dart';

enum AppRoute {
  home,
  about,
  player,
  videoGallery,
  ui,
}

extension AppRouteExt on AppRoute {
  String get path => _routes[this]?.path ?? '';
  Widget Function(BuildContext, GoRouterState) get builder =>
      _routes[this]?.builder ?? (_, __) => Container();

  static final _routes = {
    AppRoute.home: HomeView(),
    AppRoute.about: AboutView(),
    AppRoute.player: VideoPlaybackView(),
    AppRoute.videoGallery: VideoListView(),
    AppRoute.ui: UiView(),
  };
}

final router = GoRouter(
  initialLocation: '/video',
  routes: AppRoute.values
      .map((e) => GoRoute(
            name: e.name,
            path: e.path,
            builder: e.builder,
          ))
      .toList(),
);
