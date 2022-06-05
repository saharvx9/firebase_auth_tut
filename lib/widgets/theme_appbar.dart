import 'package:firebase_auth_tut/widgets/switch/themeswitch/theme_cubit.dart';
import 'package:firebase_auth_tut/widgets/switch/custom_switch.dart';
import 'package:firebase_auth_tut/widgets/switch/themeswitch/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

enum AppBarType {
  idle,
  clean
}

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final AppBarType type;

  const ThemeAppBar(
      {Key? key,
      required this.title,
      this.height = kToolbarHeight,
      this.type = AppBarType.idle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(title,style: theme.textTheme.headline2?.copyWith(color: type == AppBarType.clean ?theme.colorScheme.primary :theme.colorScheme.onPrimary),),
      backgroundColor: type == AppBarType.clean ? Colors.transparent : null,
      elevation: type == AppBarType.clean ? 0 : 5,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ThemeSwitch(),
        )
      ],
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height);
}
