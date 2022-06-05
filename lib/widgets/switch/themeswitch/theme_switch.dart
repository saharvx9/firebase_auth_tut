import 'package:firebase_auth_tut/widgets/switch/themeswitch/theme_cubit.dart';
import 'package:firebase_auth_tut/widgets/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ThemeSwitch extends StatelessWidget {
  final ThemeCubit _cubit;

  ThemeSwitch({Key? key})
      : _cubit = GetIt.I(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, SelectedTheme>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomSwitch(
            initialValue: state.brightness == Brightness.light,
            onCheck: (value) => _cubit.changeTheme(value ? Brightness.light : Brightness.dark));
      },
    );
  }
}
