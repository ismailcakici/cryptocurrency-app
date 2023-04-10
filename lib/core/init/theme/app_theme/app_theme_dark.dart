import 'package:cryptocurrency/core/init/theme/app_theme/app_theme.dart';
import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme_interface.dart';
import 'package:flutter/material.dart';


class AppThemeDark extends AppTheme with  IDarkColorScheme {
  static AppThemeDark? _instance;
  static AppThemeDark? get instance {
    _instance ??= AppThemeDark._init();
    return _instance;
  }

  AppThemeDark._init();

  @override
  ThemeData get appTheme => ThemeData(
    colorScheme: _colorScheme,
    appBarTheme: _appBarTheme,
    scaffoldBackgroundColor: darkColorScheme!.darkBlue,
    indicatorColor: darkColorScheme!.white,
    progressIndicatorTheme: _progressIndicatorTheme,
  );

  ColorScheme get _colorScheme => ColorScheme(
    brightness: darkColorScheme!.brightnessDark,
    primary: darkColorScheme!.darkBlue,
    onPrimary: darkColorScheme!.white,
    secondary: darkColorScheme!.darkGray,
    onSecondary: darkColorScheme!.white,
    error:darkColorScheme!.red,
    onError: darkColorScheme!.white,
    background: darkColorScheme!.white,
    onBackground: darkColorScheme!.darkBlue,
    surface: darkColorScheme!.darkGray,
    onSurface: darkColorScheme!.white
  );

  AppBarTheme get _appBarTheme => AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: darkColorScheme!.systemUiOverlayStyle,
    backgroundColor: darkColorScheme!.transparent,
    elevation: 0
  );

  ProgressIndicatorThemeData get _progressIndicatorTheme => ProgressIndicatorThemeData(
    color: darkColorScheme!.white,
  );

}