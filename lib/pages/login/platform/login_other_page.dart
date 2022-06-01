import 'package:firebase_auth_tut/pages/login/bloc/login_cubit.dart';
import 'package:firebase_auth_tut/pages/login/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_config.dart';
import '../../../widgets/theme_appbar.dart';

class LoginOtherPage extends StatelessWidget {

  final LoginCubit cubit;

  const LoginOtherPage({Key? key, required this.cubit}) : super(key: key);

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
        appBar: ThemeAppBar(title: "Login",type: AppBarType.clean),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.spacingExtraHorizontal,horizontal: SizeConfig.screenWidth * 0.04),
          child: SingleChildScrollView(child: LoginBody(cubit: cubit)),
        ),
      ),
    );
  }
}
