import 'dart:ui';

import 'package:firebase_auth_tut/data/prefrences/app_prefrences.dart';
import 'package:firebase_auth_tut/data/source/theme/theme_data_source.dart';

class ThemeLocalRepository implements ThemeDataSourceLocal {
  final AppPreferences _preferences;

  ThemeLocalRepository(this._preferences);

  @override
  Future<Brightness?> getBrightness() => Future(() => _preferences.brightness);

  @override
  Future<void> setBrightness(Brightness? brightness) => Future(() => _preferences.brightness = brightness);
}
