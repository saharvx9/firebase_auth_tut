import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';



class AppTheme {

  final Brightness brightness;

  static final _textTheme = TextTheme(
    headline1: TextStyle(fontSize: SizeConfig.fontLarge, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: SizeConfig.fontMedium, fontWeight: FontWeight.w600),
    headline3: TextStyle(fontSize: SizeConfig.fontNormal),
    headline4: TextStyle(fontSize: SizeConfig.fontMedium),
    headline5: TextStyle(fontSize: SizeConfig.fontSmall),
    headline6: TextStyle(fontSize: SizeConfig.fontMedium),
    subtitle1: TextStyle(fontSize: SizeConfig.fontNormal, fontWeight: FontWeight.w600),
    subtitle2: TextStyle(fontSize: SizeConfig.fontSmall),
    bodyText1: TextStyle(fontSize: SizeConfig.fontNormal, fontWeight: FontWeight.w300),
    bodyText2: TextStyle(fontSize: SizeConfig.fontSmall, fontWeight: FontWeight.w300),
    caption: TextStyle(fontSize: SizeConfig.fontNormal, fontWeight: FontWeight.bold),
    button: TextStyle(fontSize: SizeConfig.fontNormal, fontWeight: FontWeight.w600),
    overline: TextStyle(fontSize: SizeConfig.fontNormal, fontWeight: FontWeight.w400),
  );

  final _themeSchemeDark = ThemeData.dark().copyWith(
      textTheme: _textTheme,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.amber,
          onPrimary: Colors.white,
          primaryContainer: const Color(0xff676767),
          surface: const Color(0xff616161).withOpacity(0.4),
          onSurface: Colors.white,
          background: Colors.black45,
          onBackground: Colors.black26,
          secondary: Colors.white,
          onSecondary: Colors.white38,
          error: Colors.red,
          surfaceVariant: Colors.amber[500],
          onError: Colors.orangeAccent.withOpacity(0.8)));

  final _themeSchemeLight = ThemeData.light().copyWith(
      textTheme: _textTheme,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue,
          onPrimary: Colors.white,
          primaryContainer: Colors.white,
          surface: const Color(0xff616161).withOpacity(0.4),
          onSurface: const Color(0xff616161).withOpacity(0.4),
          background: Colors.white,
          onBackground: Colors.white38,
          secondary: Colors.black,
          onSecondary: Colors.black54,
          error: Colors.red,
          surfaceVariant: Colors.blue[800],
          onError: Colors.red.withOpacity(0.8)));


  ThemeData get theme => brightness == Brightness.dark ? _themeSchemeDark : _themeSchemeLight;

  AppTheme(this.brightness);

}

