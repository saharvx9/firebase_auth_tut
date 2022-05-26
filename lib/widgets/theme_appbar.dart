import 'package:firebase_auth_tut/pages/bloc/theme/theme_cubit.dart';
import 'package:firebase_auth_tut/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  late final ThemeCubit cubit;

  ThemeAppBar({Key? key, required this.title, this.height = kToolbarHeight})
      : cubit = GetIt.I(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: _themeSwitch(),
        )
      ],
    );
  }

  Widget _themeSwitch() {
    return BlocBuilder<ThemeCubit, SelectedTheme>(
      bloc: cubit,
      builder: (context, state) {
        return CustomSwitch(initialValue: state.brightness, onCheck: (value) => cubit.changeTheme(value));
      },
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height);
}
