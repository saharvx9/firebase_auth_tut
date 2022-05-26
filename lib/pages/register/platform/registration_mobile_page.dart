import 'package:firebase_auth_tut/pages/register/bloc/registration_cubit.dart';
import 'package:firebase_auth_tut/pages/register/registration_body.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../widgets/theme_appbar.dart';

class RegistrationMobilePage extends StatelessWidget {
  final RegistrationCubit cubit;

  const RegistrationMobilePage({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: "Register",),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(SizeConfig.spacingNormalVertical),
          child: RegistrationBody(cubit: cubit),
        ),
      ),
    );
  }
}

