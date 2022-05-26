import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _preferences;

  static const _brightnessKey = "brightness_key";

  AppPreferences(this._preferences);

  Brightness? get brightness {
    final result = _preferences.getString(_brightnessKey);
    if(result == Brightness.light.toString()) return Brightness.light;
    if(result == Brightness.dark.toString()) return Brightness.dark;
    else return null;
  }
  set brightness(Brightness? value)=>_preferences.setString(_brightnessKey, value?.toString() ?? "");
}
