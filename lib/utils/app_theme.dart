import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';



class AppTheme {

  final Brightness brightness;

  static final _textTheme = TextTheme(
      titleLarge: TextStyle(fontSize: SizeConfig.fontLarge, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: SizeConfig.fontMedium, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(fontSize: SizeConfig.fontNormal,fontWeight: FontWeight.w300)
  );

  final _themeSchemeDark = ThemeData.dark().copyWith(
      textTheme: _textTheme,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.amber,
          onPrimary: Colors.amber.withOpacity(0.8),
          surface: Colors.blueGrey,
          onSurface: Colors.blueGrey.withOpacity(0.8),
          background: Colors.black45,
          onBackground: Colors.black26,
          secondary: Colors.white,
          onSecondary: Colors.white38,
          error: Colors.orangeAccent,
          onError: Colors.orangeAccent.withOpacity(0.8)));

  final _themeSchemeLight = ThemeData.light().copyWith(
      textTheme: _textTheme,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue,
          onPrimary: Colors.blue.withOpacity(0.8),
          surface: Colors.white,
          onSurface: Colors.white,
          background: Colors.white,
          onBackground: Colors.white38,
          secondary: Colors.black,
          onSecondary: Colors.black54,
          error: Colors.red,
          onError: Colors.red.withOpacity(0.8)));


  ThemeData get theme => brightness == Brightness.dark ? _themeSchemeDark : _themeSchemeLight;

  AppTheme(this.brightness);

}

