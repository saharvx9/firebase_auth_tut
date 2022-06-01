import 'package:firebase_auth_tut/pages/login/bloc/login_cubit.dart';
import 'package:firebase_auth_tut/pages/login/login_body.dart';
import 'package:firebase_auth_tut/widgets/theme_appbar.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class LoginMobilePage extends StatelessWidget {

  final LoginCubit cubit;

  const LoginMobilePage({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: "Login",),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(SizeConfig.spacingNormalVertical),
        child: LoginBody(cubit: cubit),
      ),
    );
  }
}
