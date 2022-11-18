import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/overlay_dropdown.dart';
import 'package:memo_app/view/video/video_playback.dart';

final routes = {
  '/': (context) => const Home(title: 'Flutter Demo Home Page'),
  '/about': (context) => const About(title: 'Flutter Demo About Page'),
  '/overlay': (context) => const OverlayDropdown(),
  '/player': (context) => const VideoPlayback(),
};
