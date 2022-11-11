import 'package:memo_app/view/about.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/view/overlay_dropdown.dart';

final routes = {
  '/': (context) => const Home(title: 'Flutter Demo Home Page'),
  '/about': (context) => const About(title: 'Flutter Demo About Page'),
  '/overlay': (context) => const OverlayDropdown(),
};
