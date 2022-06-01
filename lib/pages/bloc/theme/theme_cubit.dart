import 'dart:ui';

import 'package:firebase_auth_tut/data/source/theme/theme_data_source.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<SelectedTheme> {
  final ThemeDataSourceLocal _themeDataSource;

  ThemeCubit(this._themeDataSource) : super(SelectedTheme(SchedulerBinding.instance.window.platformBrightness)) {
    _checkForTheme();
  }

  _checkForTheme() async {
    try {
      final brightness = await _themeDataSource.getBrightness();
      if(brightness == null) return;
      emit(SelectedTheme(brightness));
    } catch (e) {
      //ignore from error..
    }
  }

  changeTheme(Brightness brightness) async {
    print("change theme: $brightness");
    await _themeDataSource.setBrightness(brightness);
    emit(SelectedTheme(brightness));
  }
}
