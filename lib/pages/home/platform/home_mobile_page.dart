import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/pages/bloc/theme/theme_cubit.dart';
import 'package:firebase_auth_tut/pages/home/widgets/custom_flexible_space_bar.dart';
import 'package:firebase_auth_tut/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeMobilePage extends StatelessWidget {
  final User user;
  const HomeMobilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = GetIt.I<ThemeCubit>();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context,innerBoxIsScrolled) => [
          CustomFlexibleSpaceBar(
              imageUrl: user.imageUrl,
              action: BlocBuilder<ThemeCubit, SelectedTheme>(
                bloc: themeCubit,
                builder: (context, state) {
                  return ThemeSwitch(
                      initialValue: state.brightness,
                      onCheck: (value) => themeCubit.changeTheme(value));
                },
              ),
              maxSizeImage: 110,
              minSizeImage: 35),

        ],
        body: Container(
          child: const Center(child: Text("sahar"),),
        ),
      ),
    );
  }
}
