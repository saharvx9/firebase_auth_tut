import 'package:firebase_auth_tut/pages/register/platform/registration_mobile_page.dart';
import 'package:firebase_auth_tut/pages/register/platform/registration_other_page.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'bloc/registration_cubit.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = "/register";
  final RegistrationCubit cubit;

  const RegistrationPage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 600
          ? RegistrationOtherPage(cubit: widget.cubit)
          : RegistrationMobilePage(cubit: widget.cubit);
    });
  }

  @override
  void dispose() {
    widget.cubit.close();
    super.dispose();
  }
}
