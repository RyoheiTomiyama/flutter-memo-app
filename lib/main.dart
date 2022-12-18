import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:memo_app/routes.dart';

const brandColor = MaterialColor(0xFF397A8D, <int, Color>{
  50: Color(0xFFE7EFF1),
  100: Color(0xFFC4D7DD),
  200: Color(0xFF9CBDC6),
  300: Color(0xFF74A2AF),
  400: Color(0xFF578E9E),
  500: Color(0xFF397A8D),
  600: Color(0xFF337285),
  700: Color(0xFF2C677A),
  800: Color(0xFF245D70),
  900: Color(0xFF174A5D),
});
// http://mcg.mbitson.com/#!?mcgpalette0=%23e8dbb3
const brandAccentColor = MaterialColor(0xFFE8DBB3, <int, Color>{
  50: Color(0xFFFCFBF6),
  100: Color(0xFFF8F4E8),
  200: Color(0xFFF4EDD9),
  300: Color(0xFFEFE6CA),
  400: Color(0xFFEBE0BE),
  500: Color(0xFFE8DBB3),
  600: Color(0xFFE5D7AC),
  700: Color(0xFFE2D2A3),
  800: Color(0xFFDECD9A),
  900: Color(0xFFD8C48B),
});

void main() {
  Intl.defaultLocale = Platform.localeName;
  initializeDateFormatting(Intl.defaultLocale);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: brandColor,
        primaryColor: brandColor.shade500,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // primary: const Color(0xFF617E84),
          primary: brandColor.shade500,
          onPrimary: Colors.white,
          secondary: brandAccentColor.shade500,
          // secondary: const Color(0xffe8dbb3),
          onSecondary: Colors.black,
          surface: const Color(0xfff9fcfa), // button,card
          onSurface: Colors.black,
          background: const Color(0xfffbfdfd),
          onBackground: Colors.black,
        ),
        // primarySwatch: Colors.amber,
        // primaryColor: Colors.amber,
        // primaryColor: Color(0xFFFEDBD0),
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
