import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkColorScheme {
  static DarkColorScheme? _instance;
  static DarkColorScheme? get instance {
    _instance ??= DarkColorScheme._init();
    return _instance;
  }

  DarkColorScheme._init();


  final Brightness brightnessDark = Brightness.dark;
  final SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Color(0xff141B29),
    systemNavigationBarColor: Color(0xff141B29),
  );
  final Color darkBlue = const Color(0xff141B29);
  final Color darkGray = const Color(0xff1E2532);
  final Color chartGreen = const Color(0xff00BDB0);
  final Color chartRed = const Color(0xffF15950);
  final Color transparent = Colors.transparent;
  final Color white = Colors.white;
  final Color red = Colors.red;
  final Color green = Colors.green;
}