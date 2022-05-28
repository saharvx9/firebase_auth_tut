import 'package:firebase_auth_tut/pages/register/bloc/registration_cubit.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/theme_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../registration_body.dart';


class RegistrationOtherPage extends StatelessWidget {
  final RegistrationCubit cubit;

  const RegistrationOtherPage({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: _sideBackground(context)),
          Expanded(
              flex: 4,
              child: _body()),
        ],
      ),
    );
  }

  Widget _sideBackground(BuildContext context){
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.2,1),
              colors: [
                colorTheme.surfaceVariant,
                colorTheme.primary,
                colorTheme.onPrimary,
                // colorTheme.background
              ]
          )
      ),
      child: Center(
        child: Hero(
          tag: "tag_fire_logo",
          child: SvgPicture.asset("assets/images/fire_logo.svg")),
      ),
    );
  }

  Widget _body(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.spacingSmallHorizontal),
      child: Scaffold(
        appBar: ThemeAppBar(title: "Register",type: AppBarType.clean,),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.spacingExtraHorizontal,horizontal: SizeConfig.screenWidth * 0.04),
          child: SingleChildScrollView(child: RegistrationBody(cubit: cubit)),
        ),
      ),
    );
  }
}


