import 'package:flutter/material.dart';

abstract class ThemeDataSourceLocal {
  Future<void> setBrightness(Brightness? brightness);
  Future<Brightness?> getBrightness();
}