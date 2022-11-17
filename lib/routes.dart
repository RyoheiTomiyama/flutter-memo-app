import 'package:flutter/material.dart';
import 'package:memo_app/ui/layout/swipe_up_panel.dart';
import 'package:memo_app/component/player/player.dart';
import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/overlay_dropdown.dart';

final routes = {
  '/': (context) => const Home(title: 'Flutter Demo Home Page'),
  '/about': (context) => const About(title: 'Flutter Demo About Page'),
  '/overlay': (context) => const OverlayDropdown(),
  '/player': (context) => const Scaffold(
        body: SwipeUpPanel(
          body: Player(),
        ),
      ),
};
